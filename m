From: Mark Knecht <markknecht@attbi.com>
Subject: RE: How do I make -D hw:0,1 default?
Date: 03 Jun 2003 12:06:18 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054667178.2274.5.camel@Wizard.knechthome.com>
References: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Jaroslav Kysela <perex@suse.cz>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-06-03 at 11:36, Mark Knecht wrote:

> >
> > Add 'device 1' to {} section.
> >
> > 						Jaroslav
> 
> Thanks Jaroslav!
> 
> Will this make device 1 default for all applications that require sound but
> do not ask for anything specific in terms of interfaces?
> 
> Also, please ignore the email I just sent to alsa-devel 10 seconds before
> your answer arrived at my desk.
> 
> Cheers,
> Mark

Jaroslav,
   This did not work for me. I made the edits to the .asoundrc file,
tried aplay with and without the -D, then tried restarting alsa and
tried aplay again. It didn't work.

   I did read some time ago that someone had trouble getting the
.asoundrc file to link up with the Alsa driver due to the exact name
used in the .asoundrc file. Could something like that be happening here?

Thanks,
Mark


bash-2.05b$ aplay data/wave/seque~10.wav 
Playing WAVE 'data/wave/seque~10.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono
aplay: pcm_write:1025: write error: Input/output error


bash-2.05b$ aplay -D hw:0,1 data/wave/seque~10.wav 
Playing WAVE 'data/wave/seque~10.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono


bash-2.05b$ more .asoundrc 
pcm.via82xx {
    type hw
    card 0
    device 1
}

ctl.via82xx {
    type hw
    card 0
    device 1
}
bash-2.05b$ 


Wizard root # /etc/init.d/alsasound restart
 * Shutting down ALSA
modules....                                                                               [ ok ]
 * Initialising
ALSA....                                                                                        [ ok ]
 * Starting sound driver: snd-via82xx 
Wizard root # lsmod
Module                  Size  Used by    Not tainted
snd-via82xx            11692   0 
snd-ac97-codec         34624   0  [snd-via82xx]
snd-mpu401-uart         3456   0  [snd-via82xx]
snd-rawmidi            14432   0  [snd-mpu401-uart]
snd-seq-device          4192   0  [snd-rawmidi]
snd-pcm                60928   0  [snd-via82xx]
snd-timer              15240   0  [snd-pcm]
snd                    30852   0  [snd-via82xx snd-ac97-codec
snd-mpu401-uart snd-rawmidi snd-seq-device snd-pcm snd-timer]
ide-cd                 27048   0  (autoclean)
snd-page-alloc          4908   0  [snd-via82xx snd-pcm]
Wizard root # 

Wizard root # exit
logout
bash-2.05b$ aplay data/wave/seque~10.wav 
Playing WAVE 'data/wave/seque~10.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Mono
aplay: pcm_write:1025: write error: Input/output error
bash-2.05b$ 




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
