From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Scheduled alsa-lib release?
Date: Wed, 9 Mar 2016 16:47:09 +0900
Message-ID: <56DFD4FD.8090701@sakamocchi.jp>
References: <s5hr3fk9apc.wl-tiwai@suse.de> <20160309061624.GU11154@localhost>
 <s5hbn6ob2fc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 57690260515
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2016 08:47:12 +0100 (CET)
In-Reply-To: <s5hbn6ob2fc.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 9 2016 15:17, Takashi Iwai wrote:
> On Wed, 09 Mar 2016 07:16:24 +0100,
> Vinod Koul wrote:
>>
>> On Tue, Mar 08, 2016 at 05:49:19PM +0100, Takashi Iwai wrote:
>>> Hi,
>>>
>>> in the previous meeting, there have been requests about the regular
>>> "predictable" release of alsa-lib.  We thought of aligning with kernel
>>> release cycle, judging from the nature of alsa-lib.

As a quick glance of the number of commits per month (see in the end of 
this message), alsa-lib is not so actively developed recently. (except 
for topology APIs)

I think releasing every 2 months makes the release maintenance effort 
more hard than its actual advantage. It better to release alsa-lib for 2 
or more kernel release cycles.

>>> alsa-lib 1.1.0 was released in the beginning of November, which was
>>> just after 4.3 kernel release.  Now 4.5 kernel release will be likely
>>> in the next week or one week after that.
>>
>> +1
>>
>> So we should release it on monday then if Linus does release on Sunday
>
> Heh, we don't have to be that strict.  But at least we can start
> working on releasing.

For the idea itself to release alsa-lib 1.1.1 in this month, I agree.
(In this case, I might hurry up for my proposals of APIs to add control 
element set, after my work for Dice drivers will be merged into 
linux-next branch.)

>>> Jaroslav, how about releasing alsa-lib 1.1.1 around that?
>>> There are a few pending patches, but they should be available soon.
>>
>> --
>> ~Vinod

$ cd alsa-lib.git
$ git log --pretty=format:"%ad" --date=short | sed -E 
's/(....-..)-../\1/g' | sort | uniq --count
      21 1998-08
       7 1998-09
       4 1998-10
      54 1998-11
      12 1998-12
      14 1999-01
       6 1999-02
       6 1999-03
       8 1999-05
      10 1999-06
      11 1999-07
      16 1999-08
       8 1999-09next
       1 1999-10
      23 1999-11
      42 1999-12
      33 2000-01
      15 2000-02
      17 2000-03
      21 2000-04
      30 2000-05
      33 2000-06
      27 2000-07
      38 2000-08
      29 2000-09
      34 2000-10
      21 2000-11
      32 2000-12
      36 2001-01
      59 2001-02
      41 2001-03
      40 2001-04
      29 2001-05
      66 2001-06
      49 2001-07
      24 2001-08
      31 2001-09
      42 2001-10
      61 2001-11
      47 2001-12
      17 2002-01
      20 2002-02
      21 2002-03
      15 2002-04
       8 2002-05
      19 2002-06
      12 2002-07
       4 2002-08
      15 2002-09
      37 2002-10
       9 2002-11
       4 2002-12
      12 2003-01
      80 2003-02
      48 2003-03
       8 2003-04
      11 2003-05
      16 2003-06
      32 2003-07
      14 2003-08
      13 2003-09
      16 2003-10
       7 2003-11
      12 2003-12
      28 2004-01
      30 2004-02
      34 2004-03
      13 2004-04
      19 2004-05
       6 2004-06
       8 2004-07
      10 2004-08
      20 2004-09
       5 2004-10
      11 2004-11
      10 2004-12
      41 2005-01
      30 2005-02
      31 2005-03
      27 2005-04
      59 2005-05
      25 2005-06
       1 2005-07
      25 2005-08
      21 2005-09
       5 2005-10
      22 2005-11
      18 2005-12
      23 2006-01
      15 2006-02
      29 2006-03
      31 2006-04
      13 2006-05
       9 2006-06
       8 2006-07
      16 2006-08
      21 2006-09
      24 2006-10
       5 2006-11
       8 2006-12
       7 2007-01
       7 2007-02
      17 2007-03
       2 2007-04
       9 2007-05
       5 2007-06
      10 2007-07
      20 2007-08
       8 2007-09
      11 2007-10
      19 2007-11
      10 2007-12
      31 2008-01
      20 2008-02
      11 2008-03
       5 2008-04
       2 2008-05
      11 2008-06
       9 2008-07
       5 2008-08
       7 2008-09
       6 2008-10
      15 2008-11
       2 2008-12
      10 2009-01
       8 2009-02
       2 2009-03
       4 2009-04
       3 2009-05
      12 2009-06
      19 2009-07
      14 2009-08
      11 2009-09
       1 2009-10
      15 2009-11
       4 2009-12
       2 2010-01
       2 2010-02
       3 2010-03
       5 2010-04
       1 2010-05
       5 2010-07
      15 2010-08
       4 2010-09
      11 2010-10
      13 2010-11
      11 2010-12
      15 2011-01
       1 2011-02
       7 2011-03
       6 2011-04
       7 2011-05
       9 2011-06
       4 2011-07
       3 2011-08
       6 2011-09
       3 2011-10
       1 2011-11
       1 2011-12
       7 2012-01
       1 2012-02
       5 2012-03
       4 2012-04
       5 2012-05
       2 2012-06
      10 2012-07
       9 2012-08
      23 2012-09
       5 2012-10
       5 2012-11
       5 2012-12
       6 2013-01
       3 2013-02
       2 2013-03
      14 2013-04
      18 2013-05
       5 2013-06
       3 2013-07
       4 2013-08
       3 2013-09
       2 2013-10
       8 2013-11
       1 2013-12
       5 2014-01
       9 2014-02
       7 2014-03
       2 2014-04
       1 2014-05
      11 2014-06
      14 2014-07
       7 2014-08
      28 2014-09
      12 2014-11
       1 2014-12
       7 2015-01
       7 2015-02
       5 2015-03
       7 2015-04
       3 2015-05
      11 2015-06
      22 2015-07
      12 2015-08
       9 2015-09
       7 2015-10
      20 2015-11
       4 2016-01
       5 2016-02
       9 2016-03

Regards

Takashi Sakamoto
