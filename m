From: =?iso-8859-1?Q?Sh=E9rab?= <Sebastien.Hinderer@ens-lyon.org>
Subject: PC Beeps not working with HDA Intel module
Date: Sat, 26 Jun 2010 13:25:04 +0200
Message-ID: <20100626112504.GA3365__12546.0834977732$1277899233$gmane$org@pema>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toccata.ens-lyon.org (toccata.ens-lyon.fr [140.77.166.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 6221124550
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jun 2010 13:25:13 +0200 (CEST)
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
To: Matthew Ranostay <mranostay@embeddedalley.com>, Takashi Iwai <tiwai@suse.de>, PeiSen Hou <pshou@realtek.com.tw>, matt.jared@intel.com, andy.kopp@intel.com, dan.d.kogan@intel.com, Jaro
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dear all,

The problem is on a computer with an HDA Intel sound card, Intel G45
DEVCTG chip and appears will all version s of the kernel.

Running e.g.
beep 440
produces a beep whose audible frequency is very low, definitely not 440
Hz.

However, it is worth notiing that grub is able to produce a beep of the
right frequency at boot time.

Can this problem be fixed ?

Should you need any additional bit of information or testing, please ask.

Many thanks in advance for your help,
Sh=E9rab.
