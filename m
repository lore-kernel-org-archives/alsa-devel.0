From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: CVS ALSA failed upgrade in Linux 2.6.3
Date: Wed, 03 Mar 2004 01:07:47 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40452FE3.8080202@superbug.demon.co.uk>
References: <200402251411.OAA12812@liam2.demon.co.uk> <200403022335.AAA22545@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403022335.AAA22545@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: William <walsac2@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

William wrote:
> James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> 
>>Use directions at: -
>>http://alsa.opensrc.org/index.php?page=AlsaBuild2.6
>>
> 
> 
> Thanks, James.  Like I said in my previous reply to you, the section
> describing option 1 is confusing because it seems to contradict itself
> firstly by saying alsa-driver is needed (at the first paragraph) and
> secondly by saying alsa-driver might not be needed (at the end of the section)
> because Linux 2.6.3 includes alsa-driver-1.0.2,
> which misses the point of wanting to use CVS alsa-driver in the first place,
> i.e. to get the very latest drivers -- not those in alsa-driver-1.0.2.
> Basically it doesn't explain why you should install CVS alsa-drivers.
> Also it doesn't say what to do with alsa-kernel yet the cvs example shows
> alsa-kernel being checked out.  As Takashi Iwai said earlier, alsa-kernel
> includes stable drivers only and excludes new/experimental drivers.
> My understanding is you should install either alsa-kernel or CVS alsa-drivers,
> but not both of them.
> 
> William
> 
> 
The point of option 1 is to explain how to upgrade alsa if you need to. 
Not everyone needs to upgrade.
If you wish to use the cvs, you have to get alsa-driver and alsa-kernel, 
because alsa-driver uses files from ../alsa-kernel
So, if you follow the cvs command exactly it will work.

Cheers
James



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
