From: "Bankim Bhavsar" <bankim.bhavsar@gmail.com>
Subject: Definition of frame
Date: Tue, 28 Oct 2008 23:19:44 -0700
Message-ID: <4eccebac0810282319w15a5f81asbeee2c27fddcc534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 1600A243A7
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 07:19:45 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2829734rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 23:19:44 -0700 (PDT)
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

I want to clarify my understanding regarding the definition of frame
in Alsa lingo.

For a "stereo" DAC channel with 16-bit samples, number of bytes per
frame = 4 bytes, correct?
basically L & R samples each 16 bit, 16 * 2 = 32 bits = 4 bytes.

Reason being alsa-lib APIs use number of frames instead of bytes and I
want to make sure I compute right number of frames.

Thanks,
Bankim
