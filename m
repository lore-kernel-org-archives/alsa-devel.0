From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Thu, 16 Feb 2012 19:59:09 +0000
Message-ID: <20120216195908.GA32497@sirena.org.uk>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<CAN8cciaa4Htu5cS7AGuX347xY_Vbx5Uk9i4f605MRVmTQthtmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E58F103FB6
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 20:59:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN8cciaa4Htu5cS7AGuX347xY_Vbx5Uk9i4f605MRVmTQthtmw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 14, 2012 at 09:29:27AM +0800, Raymond Yau wrote:

I really shouldn't have ot remind you to not remove people from the CC
list, this is really basic stuff...

> 1) The problem of core jack api which is tailor made for embedded
> device, it assume there is only one sound card

This is not the case at all, there is no such assumption and indeed many
embedded devices have multiple sound cards.

> when the desktop computer have more than one sound cards which have jack detect
> there is no mapping to which sound card has the events.

The jack device is a child of the sound card, userspace can look at the
parent to see which sound card a given jack is associated with.

> 2) if the objective of adding jack detection is for trapping
> plug/unplug event to trigger the reconfiguration of audio server

> http://thread.gmane.org/gmane.linux.alsa.devel/89781/focus=89788

> does the audio server require to know the initial state of the hdmi
> or just need the trigger event ?

For all three of the accessory detection mechanisms the state can be
read at any time.
