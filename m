From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 0/30] ALSA: HDA VIA: patch series
Date: Sat, 10 Oct 2009 10:06:42 -0600
Message-ID: <51f3faa70910100906k3d781a6ds94e793b8e03da3dd@mail.gmail.com>
References: <4AD06ADD.4000308@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f198.google.com (mail-iw0-f198.google.com
	[209.85.223.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 26599244A0
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 18:06:43 +0200 (CEST)
Received: by iwn36 with SMTP id 36so4944205iwn.24
	for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2009 09:06:42 -0700 (PDT)
In-Reply-To: <4AD06ADD.4000308@viatech.com.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Logan Li <loganli@viatech.com.cn>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 10, 2009 at 5:07 AM, Logan Li <loganli@viatech.com.cn> wrote:
> Following patch series mainly includes:
> =A0- support VT1718S, VT2002P, VT1812S, VT1716S, ...
> =A0- support smart 5.1
> =A0- add jack detection for VT1708
> =A0- power saving functions

OK, this patch set fixes the problem with being unable to open the
mixer, and it looks like the SPDIF digital converter entries are being
enabled automatically so I get a signal indication on my receiver.
Still not getting any actual SPDIF audio through the receiver though,
unfortunately. Also it appears that the 48000 fixed sample rate limit
for SPDIF outputs is still there for the newly added codec types, I'd
say it should be removed for them as well..
