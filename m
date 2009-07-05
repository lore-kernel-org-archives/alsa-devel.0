From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: performance between access mothods!
Date: Sun, 05 Jul 2009 09:03:23 -0300
Message-ID: <4A50968B.6030201@gmail.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090705114122.GA5334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id C1FA524377
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 14:03:27 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1557994qwf.56
	for <alsa-devel@alsa-project.org>; Sun, 05 Jul 2009 05:03:27 -0700 (PDT)
In-Reply-To: <20090705114122.GA5334@sirena.org.uk>
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

Hi all!

I came across a doubt regarding the the access mode between application 
and PCM device.
It is a hardware parameter related property and there are 5 different 
types available:

SND_PCM_ACCESS_MMAP_INTERLEAVED
SND_PCM_ACCESS_MMAP_NONINTERLEAVED
SND_PCM_ACCESS_MMAP_COMPLEX
SND_PCM_ACCESS_RW_INTERLEAVED
SND_PCM_ACCESS_RW_NONINTERLEAVED

taking in account that these first 3 parameters has direct communication 
with the memory, that means a higher speed operation? And the fact of 
the interleaved has all the samples mixed together , makes any 
difference in performance in comparison to the noninterleaved that has 
samples stored on different buffers?

Thanks in advanced
