From: "Marco Schuster" <marco@harddisk.is-a-geek.org>
Subject: ultra small alsa library
Date: Sat, 2 Aug 2008 16:38:28 +0200
Message-ID: <b542c8b90808020738g76115165ve9d2d02a033706bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F4FC103825
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Aug 2008 16:38:30 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so614191nfd.32
	for <alsa-devel@alsa-project.org>; Sat, 02 Aug 2008 07:38:29 -0700 (PDT)
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

hi all,

i try to run a creative extigy via the usb port on a nslu2. the nslu2 is a
arm-based (xscale) mini-server with 32mb of ram and so very resource limited
if you let services run on it.
when i now attach the extigy and play some random stuff - doesn't matter
which player - the sound is very intermittent and not recognizable. i think
this is due to massive swapping somewhere.
what are the minimum prerequisites for using s-alsa (esp. kernel!)? with
2.6.24 and debian i got segfaults.

thank you,
marco
