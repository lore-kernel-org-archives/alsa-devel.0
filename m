From: Mark Brand <mark.brand@nmmu.ac.za>
Subject: Re: gitcompile fail
Date: Sat, 7 Jan 2017 16:14:29 +0200
Message-ID: <a5d5a532-c63c-f9a2-5bd5-e9cefbb3d056@nmmu.ac.za>
References: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from securemail-pl-omx9.synaq.com (securemail-pl-omx9.synaq.com
 [196.35.198.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8788926792F
 for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2017 15:14:41 +0100 (CET)
Received: from [197.83.213.47] (helo=[192.168.1.99])
 by securemail-pl-omx9.synaq.com with esmtpa (Exim 4.63)
 (envelope-from <mark.brand@nmmu.ac.za>) id 1cPrlT-0001so-4t
 for alsa-devel@alsa-project.org; Sat, 07 Jan 2017 16:14:35 +0200
In-Reply-To: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you sincerely for your response, Clemens.

Please forgive my noobness, but is a full kernel compilation necessary?  
I'm running Ubuntu 16.04 with 4.4.0-57-lowlatency kernel and my module 
is closely based on the existing mtpav driver.  I believe I know where 
to place my source file, and what modifications to make to the 
appropriate Kconfig and Makefile.  I recall being able to specify which 
modules I wanted to compile in arguments to ./configure (followed by 
make modules), but I don't see that option anymore.  Please, could 
someone point me in the direction of a valid, step-by-step procedure?  
Every set of instructions that I've been able to find seems to now be 
out of date.

Thank you again, in anticipation (and apologies too!)
Mark Brand
________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Saturday, January 07, 2017 11:09 AM
To: Brand, Mark (Mr) (Summerstrand Campus South); 
alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] gitcompile fail

Mark Brand wrote:
 > git clone git://github.com/tiwai/alsa-driver-build.git

Don't use that.  The ALSA drivers are part of the kernel; just compile
the kernel normally.

 > git clone git://github.com/tiwai/sound.git

This is a kernel repository.


Regards,
Clemens
