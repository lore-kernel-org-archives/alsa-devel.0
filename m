From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: ALSA docs
Date: Tue, 30 Jul 2002 02:55:52 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4581A8.80808@boosthardware.com>
References: <E17Z9If-0003MS-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>>i would personally work from a complete set of snd-* modules, and use
>>>modinfo(1) + perl to get the information
>>
>>Isn't that what happens in the INSTALL file anyway?
> 
> 
> it doesn't look like it. there are several cards missing there, and it
> looks hand-written rather then fetched from the source.
> 
> 
>>>and put that into the temp
>>>file that is inserted into the template, or if possible, put it
>>>straight into the template.
>>>
>>
>>IIRC doing the above would need access to a set of modules online. Seems 
>>unneccesary when the INSTALL file is already available.
>>
>>But I'm willing to be told otherwise if it makes the info more reliable.
> 
> 
> it would be much more reliable if you got the options from the modules
> themselves. even just running grep for MOD_PARM etc. would be better
> than using the INSTALL file.
> 

Do you mean that I should be parsing each driver file seperately?

I think it would be easier to get the autoconf process to create a file 
which prints all the modules options and controls to a file which is 
included in the main alsa-drivers source dir eg the INSTALL file. Then I 
can just parse that with php.

This will definitely save on server traffic. And hence bills.

Is there anyone who has the time to write this or at least give me a 
good very specific how to do it?

I guess some/most of the work is already done in the alsaconf scripts ???


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
