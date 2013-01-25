From: Daniel Griscom <griscom@suitable.com>
Subject: Re: ALSA versions versus kernel versions
Date: Fri, 25 Jan 2013 10:10:18 -0500
Message-ID: <p06240807cd284c6a33a7@[192.168.1.8]>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
 <1357341987-3327-3-git-send-email-rneri@dextratech.com>
 <51029A30.7070903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway14.websitewelcome.com (gateway14.websitewelcome.com
 [70.85.130.16]) by alsa0.perex.cz (Postfix) with ESMTP id 61DC7264F07
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 16:10:23 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway14.websitewelcome.com (Postfix) with ESMTP id ED35316E083B8
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 09:10:19 -0600 (CST)
Received: from [75.144.159.89] (port=50361 helo=[192.168.1.8])
 by gator683.hostgator.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80) (envelope-from <griscom@suitable.com>)
 id 1Tykv7-0004jg-1I
 for alsa-devel@alsa-project.org; Fri, 25 Jan 2013 09:10:21 -0600
In-Reply-To: <51029A30.7070903@ti.com>
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

I never got a response to my query, not even an RTFM (although I'm 
pretty sure this isn't in the M). So, in case anyone else is 
wondering, here's what I've since found:

- The kernel packages do NOT limit themselves to taking an entire 
released ALSA package. In particular, the 3.6.X series has a number 
of improvements and changes that aren't in the latest (year old) 
alsa-driver 1.0.25 package. I'll guess that they're taken directly 
from the alsa GIT repository, but it's hard to know.

- The alsa-driver package installs items that are NOT a part of the 
kernel package. The alsasound startup script and the ALSA headers are 
the examples I've found so far, but there may be more items.

- When installed, the alsa-driver package installs its modules into 
the currently running kernel's directories. So, if you want to have 
the latest system, you need to install the kernel, reboot into that 
kernel, install alsa-driver, reinstall the kernel, and reboot again. 
Ugh.


<rant>
ALSA's Achilles heel has always been its documentation, whether for 
developers (the Doxygen-generated documents are at times comically 
uninformative) or for end-users (e.g. the lack of information such as 
the above). Please: those of you in the know, spend some time 
documenting this powerful and confusing system. Yes, you know how to 
use it, but isn't the goal to have it support the thousands/millions 
of audio users out there, and not just the dozen or so core ALSA 
developers?
</rant>


Thanks,
Dan


At 4:12 PM -0500 1/17/13, Daniel Griscom wrote:
>We're working to build a consistent Linux audio environment for our 
>embedded audio product,with known versions of both ALSA and the 
>kernel (we're specifically considering kernel 3.6.6). We are not 
>clear, however, exactly what version of the ALSA kernel-space tools 
>are included with the kernel, nor are we clear on exactly what each 
>ALSA package is used for.
>
>In order to simplify any responses, I'll give my best guess as to 
>what's included in the kernel and each ALSA package: let me know 
>where I went wrong.
>
>
>So, am I right that...
>
>- Kernel 3.6.6 includes exactly alsa-driver-1.0.25 (I'm actually 
>guessing not, but let me know.)
>
>- alsa-driver-1.0.25 is all included in the kernel release, and can be ignored
>
>- alsa-lib is the user-space library that we complile our tools 
>against, and that communicates with ALSA in the kernel through the 
>device and /proc tree (required)
>
>- alsa-utils are various generic ALSA command line tools, such as 
>amixer, aplay, alsaconf, etc (required)
>
>- alsa-tools are various more obscure tools and loaders (probably 
>not required)
>
>- alsa-firmware are binary drivers for various third-party products 
>(probably not required)
>
>- alsa-plugins are plugins for various ALSA needs (e.g. Jack) 
>(probably not required)
>
>- alsa-oss is the OSS compatibilty layer (not required)
>
>- pyalsa is the Python bindings for ALSA (not required)
>
>
>And, some final questions:
>
>- What version of ALSA and the kernel are needed to fully support 
>implicit feedback?
>
>- Given our audio focus, what version kernel would you recommend?
>
>
>Thanks,
>Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
