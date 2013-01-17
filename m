From: Daniel Griscom <griscom@suitable.com>
Subject: ALSA versions versus kernel versions
Date: Thu, 17 Jan 2013 16:12:37 -0500
Message-ID: <p06240820cd1e12188fdd@[192.168.1.8]>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5h1udlp5to.wl%tiwai@suse.de>
 <CAN8ccib5gpbsyLPmfoaC4edwYjird8ViZbKKiTbo-iP4DsjsOA@mail.gmail.com>
 <s5hehhk2uee.wl%tiwai@suse.de>
 <CAN8cciZEWPdKcX2J=16ry9UVoXZwasF7GfN9O4JGwJPx+0Y8zQ@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
 <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
 <s5hsj6017km.wl%tiwai@suse.de>
 <CA+S_cwo2mZn+5P3JuNWXZ+3taQcSHmvRhm95vjupY1o+FA+cpw@mail.gmail.com>
 <s5hobgo16ct.wl%tiwai@suse.de>
 <CA+S_cwqeP90pFpFviKns-bxxBS6ahunPgRfCG0BQTa5ZLPtE-Q@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <s5hfw1zomf2.wl%tiwai@suse.de> <20130117191224.44794728@gmail.com>
 <CA+S_cwpM1Z0sPOS+TcdDni14vY7DU14F1ez4CyOkLS1LHyM1oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway16.websitewelcome.com (gateway16.websitewelcome.com
 [67.18.21.17]) by alsa0.perex.cz (Postfix) with ESMTP id 8869D265076
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 22:12:41 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway16.websitewelcome.com (Postfix) with ESMTP id 520849559FE8
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 15:12:21 -0600 (CST)
Received: from [75.144.159.89] (port=49846 helo=[192.168.1.8])
 by gator683.hostgator.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80) (envelope-from <griscom@suitable.com>)
 id 1TvwlL-0003o9-I9
 for alsa-devel@alsa-project.org; Thu, 17 Jan 2013 15:12:39 -0600
In-Reply-To: <CA+S_cwpM1Z0sPOS+TcdDni14vY7DU14F1ez4CyOkLS1LHyM1oQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We're working to build a consistent Linux audio environment for our 
embedded audio product,with known versions of both ALSA and the 
kernel (we're specifically considering kernel 3.6.6). We are not 
clear, however, exactly what version of the ALSA kernel-space tools 
are included with the kernel, nor are we clear on exactly what each 
ALSA package is used for.

In order to simplify any responses, I'll give my best guess as to 
what's included in the kernel and each ALSA package: let me know 
where I went wrong.


So, am I right that...

- Kernel 3.6.6 includes exactly alsa-driver-1.0.25 (I'm actually 
guessing not, but let me know.)

- alsa-driver-1.0.25 is all included in the kernel release, and can be ignored

- alsa-lib is the user-space library that we complile our tools 
against, and that communicates with ALSA in the kernel through the 
device and /proc tree (required)

- alsa-utils are various generic ALSA command line tools, such as 
amixer, aplay, alsaconf, etc (required)

- alsa-tools are various more obscure tools and loaders (probably not required)

- alsa-firmware are binary drivers for various third-party products 
(probably not required)

- alsa-plugins are plugins for various ALSA needs (e.g. Jack) 
(probably not required)

- alsa-oss is the OSS compatibilty layer (not required)

- pyalsa is the Python bindings for ALSA (not required)


And, some final questions:

- What version of ALSA and the kernel are needed to fully support 
implicit feedback?

- Given our audio focus, what version kernel would you recommend?


Thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
