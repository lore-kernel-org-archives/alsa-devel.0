From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Thu, 17 May 2007 11:22:56 +0200
Message-ID: <464C1EF0.2080809@gmail.com>
References: <20070517084847.550D91CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 664372442B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 11:25:38 +0200 (CEST)
In-Reply-To: <20070517084847.550D91CE303@ws1-6.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/17/2007 10:48 AM, ramkromberg@mail.com wrote:

> Yes, its like you said Rene, sb8 works although the sound is distorted 
> and the module can't be removed...
> Later I can modprobe sgalaxy too, and the sound works without a hitch.

Okay, don't know what the trouble is with that distortion (if you haven't 
set the volumes to 100, that is) but not too important right now.

> Also since now I can compile some code - your "eeprom.c" compiles and 
> works - I'm available for further testing...

I might want you to test some mode-resetting code later; will be sure to ask 
if needed.

> I also noticed that the binary you sent was 506kb while my compilation 
> is 9kb, maybe you sent an early/later version with some additional 
> includes for verbose ?
> I compiled it with "gcc -W -Wall -o eeprom eeprom.c" like you said (on 
> my xubuntu 7.04 with build-essentials deb package installed).

Now try it with "gcc -static -W -Wall -o eeprom eeprom.c". I compiled the 
binary I provided with that "-static" flag which means the program includes 
all library code directly inside the binary and doesn't link to the library 
code you already have on your system.

I did this to avoid any version problems that may exist between different 
distributions. Essentially you're only guaranteed that a dynamic executable 
will work on the system on which it was compiled (rather, on a system with 
the same versions of the libraries installed as on the system on which it 
was compiled). In this case the program only links to the system C library 
and did nothing weird so it wasn't much of an issue, but I don't even want 
to deal with any _possible_ problems of that nature...

Yes, with a normal (ie, dynamic) link that 9k is correct.

Rene.
