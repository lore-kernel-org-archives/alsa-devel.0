From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: DMX6fire / ice1712: Long initialization time for
	playback with Java
Date: 02 Nov 2003 16:22:58 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067811778.32164.13.camel@eviltwin>
References: <3FA58135.8050907@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FA58135.8050907@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steffen Sauder <steffensauder@gmx.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Just curious, but have you tried making sure that artsd is dead prior to
starting?  I only get these types of delays if I forget to kill it first
(an OS beep will start it).

Jan


On Sun, 2003-11-02 at 16:12, Steffen Sauder wrote:
> Hello,
> 
> I am working on an audio-application with java 1.4, and I noticed that 
> with the current alsa-release the time neccessary to initialize my 
> Terratec DMX6fire card for playback (in oss emulation mode) increased a 
> lot since older versions.
> 
> I wrote a small program to measure the time it takes for simply starting 
> the playback of a wav/aiff file. I noticed that the 0.9.8 release uses a 
> _lot_ more time on the AudioSystem.getMixerInfo() call (which searches 
> for all available devices) than older versions. I also noticed that the 
> times differ a lot for different JDKs, so here are the results for the 
> sun-jdk-1.4.2.01, blackdown-jdk-1.4.1 and ibm-jdk-1.4.1 with the 
> different alsa-driver versions.
> 
> alsa-driver 0.9.2 - 0.9.3a:
> sun:  3.2- 3.3 sec     bdn:  1.9- 2.0 sec   ibm:  0.7- 0.8 sec
> 
> alsa-driver 0.9.3b - 0.9.7:
> sun:  6.2- 6.3 sec     bdn: 13.7-13.8 sec   ibm:  3.7- 3.9 sec
> 
> alsa-driver 0.9.8:
> sun: 48.0-48.5 sec     bdn: 24.7-24.8 sec   ibm: 13.7-13.8 sec
> 
> alsa-driver cvs-nov-02:
> sun: 20.7-20.9 sec     bdn: 24.8-24.9 sec   ibm: 13.8-13.9 sec
> 
> So things got worse between 0.9.3a and .b (the same moment the 
> mplayer-oss-emulation-delay problem occured!) and 0.9.7 and 0.9.8. 
> Current CVS version is working a bit better for sun's jdk, but not for 
> the others. I did not try different alsa-lib versions (used 0.9.2 all 
> the time) - don't know if this would make any difference.
> 
> I attached the source code of the small programm, its syntax is:
> 
> java AudioTest AUDIOFILE [DEVICE_NO]
> 
> where DEVICE_NO is the index of the java-mixer-device to be used (they 
> get listed if you start it without the second parameter)
> 
> Gruss,
> Steffen
> ----
> 

> 
> import javax.sound.sampled.*;
> /**
>  *
>  * @author  fali
>  */
> public class AudioTest {
>   
>   /** Creates a new instance of AudioTest */
>   public AudioTest() {
>   }
>   
>   private static void playAudioFile(String fileName, int device) throws UnsupportedAudioFileException, LineUnavailableException, java.io.IOException {
>     long beginTime = System.currentTimeMillis();
> 
>     System.out.println("checking for available devices on this system...");
>     Mixer.Info[] mixerInfos = AudioSystem.getMixerInfo();
>     for (int i=0; i<mixerInfos.length; i++) {
>       System.out.println(i+" "+mixerInfos[i].getName()+"\t"+mixerInfos[i].getVendor()); 
>     }
>     System.out.println();
>     
>     System.out.println("getting mixer device "+mixerInfos[device].getName()+"...");
>     Mixer mixer = AudioSystem.getMixer(mixerInfos[device]);
>     System.out.println("got mixer device, trying to open it...");
>     mixer.open();
>     System.out.println("mixer device opened, checking supported lines...");
>     
>     Line.Info[] supportedLines = mixer.getSourceLineInfo();
>     for (int i=0; i<supportedLines.length; i++) {
>       System.out.println(supportedLines[i].toString()); 
>     }
>     System.out.println();
> 
>     java.io.File file = new java.io.File(fileName);
>     AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(file);
>     AudioFormat audioFormat = audioInputStream.getFormat();
>     System.out.println("audio file opened, format is "+audioFormat.toString());
>     
>     Line.Info lineInfo = new DataLine.Info(SourceDataLine.class, audioFormat);
>     System.out.println("obtaining SourceDataLine for that AudioFormat...");
>     SourceDataLine sourceDataLine = (SourceDataLine)mixer.getLine(lineInfo);
>     System.out.println("opening SourceDataLine...");
>     sourceDataLine.open(audioFormat);
>     System.out.println("starting SourceDataLine...");
>     sourceDataLine.start();
> 
>     long endTime = System.currentTimeMillis();
>     float seconds = (endTime-beginTime)/1000.0f;
>     System.out.println("it took "+seconds+" seconds to start playback.");
>     
>     byte[] buf = new byte[1024];
>     int bytesRead = 0;
>     while(bytesRead>=0) {
>       bytesRead = audioInputStream.read(buf);
>       if (bytesRead>0) {
>         sourceDataLine.write(buf, 0, bytesRead); 
>       }
>     }
>     
>     sourceDataLine.stop();
>     sourceDataLine.close();
>     audioInputStream.close();
>     
>   }
>   
>   public static void main(String[] args) {
>     try {
>       if (args.length==0) {
>         System.err.println("first argument has to be an audio file.");
>         System.exit(-1);
>       }
>       String fileName = args[0];
>       int device = 0;
>       if (args.length==2) {
>         device = Integer.parseInt(args[1]); 
>       }
>       playAudioFile(fileName, device);
>     } catch (Exception e) {
>       e.printStackTrace(); 
>     }
>   }
>   
> }




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
