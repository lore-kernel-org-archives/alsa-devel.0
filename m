From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: ALSA docs
Date: Mon, 29 Jul 2002 13:38:54 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D44C6DE.6030704@boosthardware.com>
References: <E17YFBD-0007ac-00@usw-sf-list1.sourceforge.net>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>I'm looking into ways to automate the modules options component file for 
>> the docs.
>>
>>At the moment I am considering using perl or mysql. Does anyone know 
>>which is easier to setup to do the following.
>>
>>Parse the INSTALL file for a module name.
>>Return the info for that module.
>>
>>Then either
>>
>>Write the module info to a temp file which is inserted into the template
>>
>> or
>>
>>insert the module info into the template.
> 
> 
> i would personally work from a complete set of snd-* modules, and use
> modinfo(1) + perl to get the information

Isn't that what happens in the INSTALL file anyway?

> and put that into the temp
> file that is inserted into the template, or if possible, put it
> straight into the template.
> 

IIRC doing the above would need access to a set of modules online. Seems 
unneccesary when the INSTALL file is already available.

But I'm willing to be told otherwise if it makes the info more reliable.

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
