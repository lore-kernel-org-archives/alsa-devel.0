From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: playback audio overwritten before it is sent to the card
Date: Fri, 26 Jul 2002 08:28:23 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020726152823.73135.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA27657
	for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2002 17:28:30 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I think that I got around understanding snd_pcm_update_hw_ptr_interrupt()=
 now.
The reason of my enquiries is that I get a very strange behaviour while p=
laying
back audio on a sound card: the playback_copy() function is called too ma=
ny
times before audio is actually played out, thus overwriting the buffer. F=
or
instance, with 2 periods of 160 bytes (buffer_size =3D 320):

playback_prepare() on sound dev0
snd_pci2103_mode() on sound dev0,  bsize:320  psize:160  pnsam:160
playback_prepare() on sound dev0
playback_copy() on sound dev0,  pos:0 ->160
    from d0865000 to c19e0000: =FF =FF =FF =FF =FF =FF =FF =FF
card 0: Sending Audio_Data  fmt:1  cnt:160 (160 bytes)  last:0  pos:160
tasklet: send 24 bytes of dataPayload (including 0 bytes of mmTags)
tasklet: send 160 bytes of extPayload from c19e0000 to 800020a0
    =FF =FF =FF =FF =FF =FF =FF =FF
playback_pointer() on sound dev0,  last:160  pos:160  ptr:160
playback_prepare() on sound dev0
playback_copy() on sound dev0,  pos:160 ->320
    from d0865000 to c19e00a0: g =FF =FF =FF =FF =FF =FF =FF
playback_pointer() on sound dev0,  last:160  pos:320  ptr:160
playback_copy() on sound dev0,  pos:0 ->160
    from d0865000 to c19e0000: g g [ [ [ S S S
playback_prepare() on sound dev0
playback_copy() on sound dev0,  pos:160 ->320
    from d0865000 to c19e00a0: g g [ [ [ S S S
playback_pointer() on sound dev0,  last:160  pos:320  ptr:160
playback_copy() on sound dev0,  pos:0 ->160
    from d0865000 to c19e0000: =DB =E7 =E7 =E7 =FF =FF =FF g
playback_prepare() on sound dev0
playback_copy() on sound dev0,  pos:160 ->320
    from d0865000 to c19e00a0: =DB =E7 =E7 =E7 =FF =FF =FF g
playback_pointer() on sound dev0,  last:160  pos:320  ptr:160
playback_copy() on sound dev0,  pos:0 ->160
    from d0865000 to c19e0000: =D3 =DB =DB =DB =DB =DB =DB =DB
playback_prepare() on sound dev0
playback_copy() on sound dev0,  pos:160 ->320
    from d0865000 to c19e00a0: =D3 =DB =DB =DB =DB =DB =DB =DB
card 0: Sending Audio_Data  fmt:1  cnt:160 (160 bytes)  last:160  pos:320
tasklet: send 24 bytes of dataPayload (including 0 bytes of mmTags)
tasklet: send 160 bytes of extPayload from c19e00a0 to 80002220
    =D3 =DB =DB =DB =DB =DB =DB =DB
playback_pointer() on sound dev0,  last:320  pos:320  ptr:0


This is puzzling, and the fact that I moved from ALSA rc1 to rc2 at the s=
ame
time that I was changing some aspects of the driver make it more difficul=
t to
trace where the error comes from. Can any of you make something out of th=
at
log?

Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
