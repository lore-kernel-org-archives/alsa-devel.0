From: Rob <alsa@rob-otics.com>
Subject: What causes a STOP in the trigger?
Date: Wed, 12 Sep 2018 23:09:49 -0700
Message-ID: <CALAeOVNOMzpvRtRoCrJP7fz3CKJppybFzkLMM=N4fQo4wYTgQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3436790628408193021=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/alsa-user>,
 <mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
 <mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3436790628408193021==
Content-Type: multipart/alternative; boundary="00000000000093e8600575ba8eaa"

--00000000000093e8600575ba8eaa
Content-Type: text/plain; charset="UTF-8"

I'm seeing a weird issue where ALSA doesn't ever hit the pointer function,
and we go straight from START to STOP. Debugging the DMA, we get IRQs, I
call the period_elapsed.

It looks like we hit STOP before we even get the first IRQ. I've checked my
parentheses, and theres no overrun or underrun messages. I don't hit the
close function, nor any other functions until i control-C. Once I do that,
I get a large series of pointer() printks showing multiples of IRQ
positions, as if it queued up the commands...

I thought I was IRQing too fast maybe, but as mentioned above, the
irqreturn function doesn't even get called before we STOP.

What in aplay would instantly force a STOP?

Audio plays a few frames (I can hear a chord), then stalls and repeats
until i Ctrl-C.

Thanks,
Rob

--00000000000093e8600575ba8eaa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m seeing a weird issue where ALSA doesn&#39;t e=
ver hit the pointer function, and we go straight from START to STOP. Debugg=
ing the DMA, we get IRQs, I call the period_elapsed.</div><div><br></div><d=
iv>It looks like we hit STOP before we even get the first IRQ. I&#39;ve che=
cked my parentheses, and theres no overrun or underrun messages. I don&#39;=
t hit the close function, nor any other functions until i control-C. Once I=
 do that, I get a large series of pointer() printks showing multiples of IR=
Q positions, as if it queued up the commands...<br></div><div><br></div><di=
v>I thought I was IRQing too fast maybe, but as mentioned above, the irqret=
urn function doesn&#39;t even get called before we STOP.<br></div><div><br>=
</div><div>What in aplay would instantly force a STOP?</div><div><br></div>=
<div>Audio plays a few frames (I can hear a chord), then stalls and repeats=
 until i Ctrl-C.<br></div><div><br></div><div>Thanks,</div><div>Rob</div><d=
iv><br></div></div>

--00000000000093e8600575ba8eaa--


--===============3436790628408193021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3436790628408193021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============3436790628408193021==--
