From: Kusanagi Kouichi <slash@ma.neweb.ne.jp>
Subject: Re: [PATCH] ALSA: hda - Add digital BEEP
	generator	support for Realtek codecs.
Date: Tue, 3 Feb 2009 23:28:51 +0900
Message-ID: <200902031428523216360006MA62@nm06mta.auone-net.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nmomta.auone-net.jp (nm06omta07.auone-net.jp [219.125.112.24])
	by alsa0.perex.cz (Postfix) with SMTP id 008A310384F
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 15:28:55 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry for the late reply.

On Mon, Nov 17, 2008 at 17:53:34PM +0100, Takashi Iwai wrote:
> Thanks for the patch.  Do these beep widgets have the mute amp bits?
> If not, we'd likely need to add mute switches as well (otherwise it
> gets too annoying) controlling on software.  Check patch_sigmatel.c in
> the latest master branch or topic/fix/hda branch of sound git tree:
>     git://git.kernel.org/pub/scm/linux/kernel/tiwai/sound-2.6.git

Every codec can mute beep.


> Another concern is that I don't want to add the digital beep control
> unconditionally.  On many devices, the beep is implemented in the old
> good analog way.  We'd need to add the check of analog/digital beep in
> a new spec field and in the preset table not to duplicate beep
> controls on these.

I don't think such a check is needed.  I presume that analog beep in
is disabled while digital beep generetor is being used.
Furthermore, keyboard bell rings only one device even if both
HDA Digital PCBeep and PC Speaker have been registered.
