From: Pete Black <pete@claudia.daemon.sh>
Subject: Re: rc3 doesn't compile
Date: Wed, 21 Aug 2002 10:49:04 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D62C760.5080209@claudia.daemon.sh>
References: <20020821194353.77069.qmail@web11507.mail.yahoo.com> <20020821234207.6be1df05.ketelaars@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from claudia.daemon.sh (202-0-34-141.cable.paradise.net.nz [202.0.34.141])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA07238
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 01:20:53 +0200
Received: from claudia.daemon.sh (unknown [192.168.1.170])
	by claudia.daemon.sh (Postfix) with ESMTP id 76ACE6833
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 11:05:15 +1200 (NZST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Or at least put a big, blinking (ok, maybe not blinking) notice on the 
ALSA home-page stating that RC3 is broken and will not compile without 
this fix.

It will save many people a lot of frustration.

-Pete

>On Wed, 21 Aug 2002 12:43:53 -0700 (PDT)
>Guilhem Tardy <guilhem_tardy@yahoo.com> wrote:
>
>  
>
>>Hi,
>>
>>Is this a common occurence that rc3 doesn't compile?
>>In my case, there are all sorts of isa-pnp related functions that have already
>>been defined. Note that I did NOT turn isa-pnp ON (the INSTALL files implies
>>default is OFF).
>>
>>Regards,
>>Guilhem.
>>    
>>
>
>--------------------------------------------------------------------------
>From: Adam Jones <alsa@yggdrasl.demon.co.uk>
>To: alsa-user ML <alsa-user@lists.sourceforge.net>
>Reply-To: adam@yggdrasl.demon.co.uk
>Subject: [Alsa-user] Re: driver 0.5.12a fails compile with arch=i486
>Date: Mon, 19 Aug 2002 06:17:00 +0100
>Sender: alsa-user-admin@lists.sourceforge.net
>Organization: Z'ha'dum Asteroid Mining Corp
>X-Mailer: YAM 2.3 [040] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch/
>
>On 18-Aug-02, Tom Whiting wrote:
>
>  
>
>>On Sunday 18 August 2002 05:24 pm, Frans Ketelaars wrote:
>>    
>>
>>>*** N.B. The 0.5.x series is considered deprecated and is no longer
>>>supported by ALSA developers ***
>>>      
>>>
>>Sadly, the Release Candidates don't even compile on all machines
>>    
>>
>
>I think Takashi's already spotted this issue:
>
>  
>
>>looks like a wrong file came into rc3 tarball accidentally.
>>for compiling rc3 alsa-driver, please remove the file
>>
>>    alsa-driver-0.9.0rc3/include/linux/isapnp.h
>>
>>before running configure script.
>>    
>>
>
>Personally I'd suggest that a compile failure merits updating the
>tarballs on the front page - 0.9.0rc3a or something like that - because
>compilation failures are guaranteed to put people off ALSA for good.
>  
>





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
