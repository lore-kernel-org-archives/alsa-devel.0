From: "Robert Rozman" <rozman@fri.uni-lj.si>
Subject: Re: Problems with SI7012 on simulated 3 stereo channels and dmix
Date: Sun, 27 Jun 2004 23:07:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <027e01c45c8b$04ffd0a0$6500a8c0@Lapitopi>
References: <040601c45b9e$07ae4b80$6500a8c0@Lapitopi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'd kindly ask also for another answer:
- why aplay doesn't play on "plug:a", b or c in system with attached
asoundrc ? It just sits there doing nothing - using -vvv doesn't help either
to spit out more info about problem...


Thanks ,

Robert.

----- Original Message ----- 
From: "Robert Rozman" <rozman@fri.uni-lj.si>
To: <alsa-devel@lists.sourceforge.net>
Sent: Saturday, June 26, 2004 6:51 PM
Subject: [Alsa-devel] Problems with SI7012 on simulated 3 stereo channels
and dmix


> Hi,
>
> I'm trying for over a month to get dmix working on 3 separate stereo
> channels on SI7012 device but no success. I just get scrambled sound when
> two apps (with same or different sample rate) are trying to access same
> device (plug:a, b or c for example).
>
> I'm attaching my asound.conf. On dmixer device everything works ok, but
when
> I try to run two instances of Alsaplayer on plug:a device I get scrambled
> sound as long as instances are running - if I stop one of them - sound
gets
> OK. This all happens also of two different sample rate files are palyed on
> same device.
>
> Since I'm newbie to asoundrc magic, I kindly ask for any guidance - I'd
love
> to get this working...
>
> Regards,
>
> Robert
>
> ----------------------------asound.conf-----------------------------------
--
>
> pcm_slave.sis {
> pcm "hw:0"
> channels 6
> rate 48000
> buffer_size 4096  # make these sizes smaller for lower latency
> period_size 2048
> periods 0
> period_time 0
> }
>
> pcm.ch12 {
> type dmix
> ipc_key 47110815
> slave sis
> bindings.0 0
> bindings.1 1
> }
>
> pcm.ch34 {
> type dmix
> ipc_key 47110815
> slave sis
> bindings.0 2
> bindings.1 3
> }
>
> pcm.ch56 {
> type dmix
> ipc_key 47110815
> slave sis
> bindings.0 4
> bindings.1 5
> }
>
>
> pcm.a {
> type plug
> slave.pcm ch12
> }
>
> pcm.b {
> type plug
> slave.pcm ch34
> }
>
> pcm.c {
> type plug
> slave.pcm ch56
> }
>
> pcm.dsp0 {
>     type plug
>     slave.pcm "dmixer"
> }
>
> pcm.dmixer  {
>     type dmix
>     ipc_key 1024
>     slave {
>         pcm "hw:0,0"
>         period_time 0
>         period_size 1024
>         buffer_size 8192
>         #periods 128
>         rate 44100
>     }
>     bindings {
>         0 0
>         1 1
>     }
> }
>
> ctl.mixer0 {
>     type hw
>     card 0
> }
>
>
>
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
> digital self defense, top technical experts, no vendor pitches,
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
