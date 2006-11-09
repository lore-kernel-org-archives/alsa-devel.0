From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Rawmidi device naming
Date: Thu, 09 Nov 2006 15:36:37 -0500
Message-ID: <1163104597.16030.6.camel@mindpipe>
References: <1158946723.1097.90.camel@mindpipe>
	<1158948259.1036.271601876@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1158948259.1036.271601876@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-09-22 at 20:04 +0200, Clemens Ladisch wrote:
> Lee Revell wrote:
> >  # aplaymidi -l
> >  Port    Client name                      Port name
> >  64:0    Dreamchip MPU interface 1        Dreamchip MPU interface 1
> >  64:32   Dreamchip MPU interface 1        Dreamchip MPU interface 2
> > 
> > Why do both ports get "Dreamchip MPU interface 1" for the client name? 
> 
> Because there is only one client.
> 
> The client name comes from the card's shortname.

Sorry, but you are wrong - the client name does not come from the card's
shortname.  The client gets the name of the first port registered.

I changed my code to:

212 
213         if ((err = snd_dream_midi_init(dream, midi2, 1, "MIDI Out")) < 0)
214                 return err;
215         midi2->port = MPU1_DATA;
216 
217         if ((err = snd_dream_midi_init(dream, midi1, 0, "GM Synth")) < 0)
218                 return err;
219         midi1->port = MPU1_DATA;
220 

And now I get:

 Port    Client name                      Port name                             
 64:0    GM Synth                         GM Synth                              
 64:32   GM Synth                         MIDI Out                              

How can I name the client independently from the ports?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
