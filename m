From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: some questions about sound system
Date: Sun, 01 Aug 2010 10:22:51 +0200
Message-ID: <4C552EDB.1020301@canonical.com>
References: <AANLkTinPWzmmaP9OrHLKbZqCgGQuSGrpqUPtdW2Qi8ov@mail.gmail.com>	<AANLkTi=A27r6QhQGdK8=HhsPbTKphoGB6GNZ3M6MHbns@mail.gmail.com>	<AANLkTin_er-Ytg6hpF+jN3p6qoRnmEag==OjJLw_iD_J@mail.gmail.com>	<AANLkTim+O7BmWopW1U_G0hQEwChJSy-On+RZiiVj=KhF@mail.gmail.com>
	<AANLkTikVsWmZkcNb7svt=-19byeBeBg4G+42Y_9yR6X1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id AB8122414E
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Aug 2010 10:22:52 +0200 (CEST)
In-Reply-To: <AANLkTikVsWmZkcNb7svt=-19byeBeBg4G+42Y_9yR6X1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: loody <miloody@gmail.com>
Cc: Daniel Chen <seven.steps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-07-31 18:31, Daniel Chen skrev:
> On Sat, Jul 31, 2010 at 12:21 PM, loody <miloody@gmail.com> wrote:
>> checking for new_panel in -lpanelw... no
>> configure: error: panelw library not found
> 
> $ sudo aptitude install libncurses5-dev

Also try installing libncursesw5-dev. There was a change in build
dependencies between karmic and lucid, so the newest version of ALSA
likely requires ncursesw5 whereas the version shipped with karmic only
required ncurses5.

Note that if you only need the kernel part of ALSA, Ubuntu has prebuilt
packages both for 1.0.23 and the latest snapshot.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
