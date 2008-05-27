From: "Janto Schraiber" <brutus.dmc@googlemail.com>
Subject: Re: [alsa-devel] ICH8 HDA not detected after upgrade
	from Ubuntu 7.10 to 8.04
Date: Tue, 27 May 2008 15:17:40 +0200
Message-ID: <5ea2cfca0805270617k6175118fj6ef902f9df0d6f6b@mail.gmail.com>
References: <5ea2cfca0805250944g3705aa41jb78f3b89e43075ef@mail.gmail.com>
	<4839DF2B.7020501@cox.net> <s5hbq2ttjjz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2045705043=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbq2ttjjz.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============2045705043==
Content-Type: multipart/alternative;
	boundary="----=_Part_19106_12953604.1211894260640"

------=_Part_19106_12953604.1211894260640
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your suggestions and sorry for my late response, I'm drowning
in work ;)


Nigel Henry wrote:
> I don't have an instance of Hardy Heron (8.04) installed at the
> moment, but it may be worth looking in synaptic, and if the
> alsa-plugins-pulseaudio package is there, remove it. it will at least
> remove pulseaudio from possibly compounding your sound problems, and
> when, and if you get the sounds working, you can always just
> re-install the package, if you want pulseaudio that is.

While there is no package called 'alsa-plugins-pulseaudio' in 8.04 (see
http://dpaste.com/53030/ for the default installed pulse packages), I
removed it per 'sudo apt-get purge pulseaudio', but it seems not to affect
my problem (since the card is not - yet - detected I didn't even start to
mess with soundconfiguration / setting up the soundserver).

The problem really seems to be a hardware vs. kernel one and since it
works in earlier kernels it's clearly a regression :( Nailing it down is
somewhat harder since there a various different errors with the same
outcome: no sound with this chipset. Those I came across while looking
for a solution: Card is not detected at all, problems loading codec and
module could not be loaded because of unknown symbols. There are also
problems because some modules won't load per default and others where
the sound is working, but with extremely low volume.


Takashi Iwai wrote:
> You should have more messages than that.  It's just the end result,
> not the cause...

I'm not sure what's caused this, but I guess this is the whole part:

[ 41.554112] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) ->
IRQ 21
[ 41.554119] PCI: Unable to reserve mem region #1:4000@febf8000 for device
0000:00:1b.0
[ 41.554123] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[ 41.554131] HDA Intel: probe of 0000:00:1b.0 failed with error -16

You can see my whole dmesg here:
http://ubuntuusers.de/paste/225479/

> Most likely you didn't enable CONFIG_SND_HDA_* kconfig items.  But
> it's just a wild guess.

I'm not sure how to check:

$cat /boot/config-2.6.24-16-generic | grep SND
# CONFIG_SND is not set

$cat /boot/config-2.6.24-17-generic | grep SND
# CONFIG_SND is not set

Is that what you mean?


klondike wrote:
> PS: Janto it'd be nice if you post a bug report on launchpad so
> Ubuntu developers also know this issue.

I found a bug on launchpad, that seems to fit to my problem:
https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644

I will post my error-report there too.

For Dell Laptops there are some suggestions on how to fix this:
http://linux.dell.com/wiki/index.php/Ubuntu_8.04
http://linux.dell.com/wiki/index.php/Ubuntu_8.04/Issues/No_Sound_After_Distribution_Upgrade

A general workaround is also suggested: One could use the -rt kernel, sound
should work there. I will test that later (no time right now) and keep you
posted.

The posts from Warren Turkal look especially interesting:
https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644/comments/46
https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644/comments/47


Thanks for your time
-janto

------=_Part_19106_12953604.1211894260640
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your suggestions and sorry for my late response, I&#39;m drowning<br>
in work ;)<br>
<br>
<br>
Nigel Henry wrote:<br>
&gt; I don&#39;t have an instance of Hardy Heron (8.04) installed at the<br>
&gt; moment, but it may be worth looking in synaptic, and if the <br>
&gt; alsa-plugins-pulseaudio package is there, remove it. it will at least <br>
&gt; remove pulseaudio from possibly compounding your sound problems, and <br>
&gt; when, and if you get the sounds working, you can always just <br>
&gt; re-install the package, if you want pulseaudio that is.<br>
<br>
While there is no package called &#39;alsa-plugins-pulseaudio&#39; in 8.04 (see
<a href="http://dpaste.com/53030/">http://dpaste.com/53030/</a> for the default installed pulse packages), I
removed it per &#39;sudo apt-get purge pulseaudio&#39;, but it seems not to
affect my problem (since the card is not - yet - detected I didn&#39;t even
start to mess with soundconfiguration / setting up the soundserver).<br>
<br>
The problem really seems to be a hardware vs. kernel one and since it<br>
works in earlier kernels it&#39;s clearly a regression :( Nailing it down
is&nbsp; somewhat harder since there a various different errors with the same<br>
outcome: no sound with this chipset. Those I came across while looking<br>
for a solution: Card is not detected at all, problems loading codec and <br>
module could not be loaded because of unknown symbols. There are also<br>
problems because some modules won&#39;t load per default and others where<br>
the sound is working, but with extremely low volume.<br>
<br>
<br>
Takashi Iwai wrote:<br>
&gt; You should have more messages than that.&nbsp; It&#39;s just the end result,<br>
&gt; not the cause...<br>
<br>
I&#39;m not sure what&#39;s caused this, but I guess this is the whole part:<br>
<br>
[ 41.554112] ACPI: PCI Interrupt 0000:00:1b.0[A] -&gt; GSI 22 (level, low) -&gt; IRQ 21<br>
[ 41.554119] PCI: Unable to reserve mem region #1:4000@febf8000 for device 0000:00:1b.0<br>
[ 41.554123] ACPI: PCI interrupt for device 0000:00:1b.0 disabled<br>
[ 41.554131] HDA Intel: probe of 0000:00:1b.0 failed with error -16<br>
<br>
You can see my whole dmesg here:<br>
<a href="http://ubuntuusers.de/paste/225479/">http://ubuntuusers.de/paste/225479/</a><br>
<br>
&gt; Most likely you didn&#39;t enable CONFIG_SND_HDA_* kconfig items.&nbsp; But<br>
&gt; it&#39;s just a wild guess.<br>
<br>
I&#39;m not sure how to check:<br>
<br>
$cat /boot/config-2.6.24-16-generic | grep SND<br>
# CONFIG_SND is not set<br>
<br>
$cat /boot/config-2.6.24-17-generic | grep SND<br>
# CONFIG_SND is not set<br>
<br>
Is that what you mean?<br>
<br>
<br>
klondike wrote:<br>
&gt; PS: Janto it&#39;d be nice if you post a bug report on launchpad so<br>
&gt; Ubuntu developers also know this issue.<br>
<br>
I found a bug on launchpad, that seems to fit to my problem:<br>
<a href="https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644">https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644</a><br>
<br>
I will post my error-report there too.<br>
<br>
For Dell Laptops there are some suggestions on how to fix this: <br>
<a href="http://linux.dell.com/wiki/index.php/Ubuntu_8.04">http://linux.dell.com/wiki/index.php/Ubuntu_8.04</a><br>
<a href="http://linux.dell.com/wiki/index.php/Ubuntu_8.04/Issues/No_Sound_After_Distribution_Upgrade">http://linux.dell.com/wiki/index.php/Ubuntu_8.04/Issues/No_Sound_After_Distribution_Upgrade</a><br>
<br>
A general workaround is also suggested: One could use the -rt kernel,
sound should work there. I will test that later (no time right now) and
keep you posted.<br>
<br>
The posts from Warren Turkal look especially interesting:<br>
<a href="https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644/comments/46">https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644/comments/46</a><br>
<a href="https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644/comments/47">https://bugs.launchpad.net/ubuntu/+source/linux-ubuntu-modules-2.6.24/+bug/211644/comments/47</a><br>
<br>
<br>
Thanks for your time<br>
-janto<br>
<br>

------=_Part_19106_12953604.1211894260640--


--===============2045705043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2045705043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============2045705043==--
