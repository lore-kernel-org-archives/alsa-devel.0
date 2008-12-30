From: cocala <syy.wxd@gmail.com>
Subject: How to handle multiple sound cards?
Date: Tue, 30 Dec 2008 18:53:25 +0800
Message-ID: <458a17f90812300253k565435e6mfdb0c4d14360fc02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id F19A22412E
	for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2008 11:53:26 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so4663454rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2008 02:53:25 -0800 (PST)
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

Hi,

Our platform has multiple sound cards: Stereo, Surround51, spdif and
Bluetooth PCM.

These sound cards are registered in random order as some sound card are
registered as module or not registered sometimes. So the application can't
use directly use the card number for specific sound card. If using alias,
the asound.conf also should be changed according to the registered sound
card after boot up.

What's the best way to handle multiple sound cards?
