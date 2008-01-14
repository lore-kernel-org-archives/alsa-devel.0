From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Mon, 14 Jan 2008 12:53:02 -0200
Message-ID: <5f52f6d70801140653o6e52984fq653bfacfa0ef5033@mail.gmail.com>
References: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
	<5f52f6d70801121901p739c8ab2rd3755c8d21047db2@mail.gmail.com>
	<BAY109-W299C00A390D5FBCF60AF6BA9450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.182])
	by alsa0.perex.cz (Postfix) with ESMTP id CD55424518
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 15:53:04 +0100 (CET)
Received: by ro-out-1112.google.com with SMTP id h4so2803062roe.10
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 06:53:03 -0800 (PST)
In-Reply-To: <BAY109-W299C00A390D5FBCF60AF6BA9450@phx.gbl>
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
To: De Fuuss <fuuss@hotmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Jan 13, 2008 4:06 PM, De Fuuss <fuuss@hotmail.com> wrote:

> Following your advice, I tested per channel output. Using either 6stack-dig or 6stack-hp, I get noise from Front Left and Right jacks, using speaker-test (X=1 and 2) but not on any other channels.

Hmm, that's strange. Make sure the rear, side and clfe channels are
unmuted in the mixer.
