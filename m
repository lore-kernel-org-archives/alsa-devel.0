From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Test model
Date: Mon, 20 Feb 2006 10:03:12 +1030 (CST)
Message-ID: <200602192333.k1JNXCKp018481@auster.physics.adelaide.edu.au>
References: <43F8A548.5060109@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F8A548.5060109@akl.lt> from "Rimas Kudelis" at Feb 19, 2006 07:05:12 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Rimas

> i've been looking at the hda driver on my acer for the past few days. 
> I got almost no results, except one note. According to the datasheel, 
> NID 0x05 accepts one more item as capture source, and values 0x05 and 
> 0x06 have different meanings from those for NID 0x04.

This is true, and it is true that the test model doesn't account for this.
The reason is simple enough: the differences didn't affect the Fujitsu since
LINE-OUT and HP-OUT aren't actually used for anything you'd want to record. 
When I came to do the test model I therefore never gave the differences a
moment's thought.

> However, it looks like fixing this would require a little more 
> knowledge than i've got.

I think it's fairly simple to address this issue.  I'll see if I can do up a
patch sometime today to address this issue.

Note that this has nothing to do with the inability to make the internal
speaker play ball on your laptop - it affects only the ability to record
from certain widgets via the second ADC (0x05) since the existing capture list
is for NID 0x04.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
