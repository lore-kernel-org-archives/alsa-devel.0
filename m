From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 14:35:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110E615.2090304@superbug.demon.co.uk>
References: <200408041224.i74COghx020422@localhost.localdomain> <4110D9FF.0@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4110D9FF.0@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ed Wildgoose wrote:
> 
> I'm not sure what you are saying here.  I have the source code in front 
> of me in an editor, but I physically can't set the options correctly - 
> the driver just rejects them?
> 
> The issue is the heuristic - I appear to have to try for the period size 
> first, then set the number of periods (fails if I do it the other way 
> around), however, if I then discover the number of periods * period size 
> is lower than I would like, I cant go and adjust these settings (alsa 
> returns errors).
> 

Why don't you use the alsa api more fully.
You can gather information about min/max period/buffer sizes before 
setting any values.
This is not 100% certain to work, as alsa hardware contraints can be 
extremely complicated if the hardware so desires.

But I do think that the setting of period_size/time, buffer_size/time 
and periods has always been problematic in alsa.

Being able test different period and buffer sizes without having to 
close/open the device would be a useful addition to the alsa api.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
