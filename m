From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: ALSA docs
Date: Tue, 30 Jul 2002 05:25:06 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D45A4A2.5010602@boosthardware.com>
References: <E17ZEzS-0001Sf-00@usw-sf-list1.sourceforge.net> <3D459394.80104@boosthardware.com>
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

>> Paul Davis wrote:
>>
>> #!/usr/local/bin/perl
>>
>> while(<>) {
>>       if (/MODULE_PARM_DESC/) {
>>           @foo = split /[()]/;
>>               @bar = split (/,/, $foo[1], 2);
>>           $bar[1] =~ s/"//g;
>>               printf ("%-32s %s\n", $bar[0], $bar[1]);
>>           }
>> }
>>
>> add something to recurse through the source tree, and include the
>> module name and card name info, and you're pretty much done ...
>>

I tried the above but it didn't work for me by itself and I don't have 
the insight at the moment to get it to. Thanks anyway because you jogged 
my memory.

I remembered that Jaroslav had given me a command a while ago (last 
year) to get the  module options for each module.

modinfo $(modprobe -l snd-*) | cat > /art/code/alsa/modinfo

This returns a reasonably readable file. If I make a perl script to 
parse that and print a more readable version then I have what I need for 
now.

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
