From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: ALSA docs
Date: Tue, 30 Jul 2002 04:12:20 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D459394.80104@boosthardware.com>
References: <E17ZEzS-0001Sf-00@usw-sf-list1.sourceforge.net>
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
Cc: alsa-devel@lists.sourceforge.net, goemon@anime.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>Do you mean that I should be parsing each driver file seperately?
> 
> 
> not really, just do a single pass over each one of them at some point
> in time. store the results, and use them. this should get you started
> (its not perfect, but it doesn't do a bad job.
> 
> #!/usr/local/bin/perl
> 
> while(<>) {
> 	  if (/MODULE_PARM_DESC/) {
> 	      @foo = split /[()]/;
>               @bar = split (/,/, $foo[1], 2);
> 	      $bar[1] =~ s/"//g;
>               printf ("%-32s %s\n", $bar[0], $bar[1]);
>           }
> }
> 
> add something to recurse through the source tree, and include the
> module name and card name info, and you're pretty much done ...
> 

Now that I think about it I could probably get away with doing this on 
my computer everytime that a new driver is added. We have to add the 
info manually for the soundcard matrix anyway.

Although If I don't have access to a working Linux computer in the 
future this will cause problems. Ideally I would like a way to do this 
all from online preferably automagically.

I'm loathe to admit but I am very new to perl so I don't even know how 
to call the above code from a webpage. Is it possible to get the perl 
script to parse the files and then use php to parse the output of the 
perl script? I have various variables from a form which php can 
understand and use to create the correct output in the template.

Unless Dan Hollis speaks up soon (I tried to contact him last Friday) 
I'm officially commandeering the Soundcard matrix from his dir and 
putting it in the alsa-docs dir. Where it will become the opening page 
to the driver docs. He will need to get cvs access for the www dir from 
Jaroslav to edit the new version of the matrix.

You can see what I'm trying to do here:

http://www.alsa-project.org/alsa-doc/ALSA_Soundcard_Matrix.php3

That is unless other people have a better idea for how to make the docs 
more user friendly (and competitive ;] ).

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
