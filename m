From: Michael Downey <downey@zymeta.com>
Subject: Re: hda-intel module hanging if ACPI enabled
Date: Wed, 05 Oct 2005 10:29:20 -0600
Message-ID: <4343FF60.5040903@zymeta.com>
References: <433C261D.8090100@zymeta.com> <20050929105612.A8457@cox.net> <433C2EDD.4050005@zymeta.com> <20050929115517.C8457@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050929115517.C8457@cox.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Matt Porter wrote:

>Ugh, this is supposed to have a unique identifying value. Did
>you get a very early board from Intel?
>
>  
>
>>The board has a BIOS revision string of: 
>>NT9410J.86A.1348.2005.0609.1737. I see that there is a newer BIOS 2104 
>>released on Sept. 2 so updating the BIOS might make a difference. I will 
>>probably try the update in a day or two so I'll post my results then.
>>    
>>
>
>You can check. However, I've looked at the BIOS updates that appear
>to have no changes related to the HDA config default regs. My
>current patches load up the appropriate config default values but
>I currently have an issue with reliably identifying the appropriate
>board for each set of values.
>
>You'll also need the patch update to get the retasking controls.
> 
>I'm working with SigmaTel on this so let me check on some things
>regarding board ID and then I'll hopefully have a patch to post
>that will work for you.  We may have to resort to manually
>specifying the model type for these boards...I'm hoping to
>avoid that though.
>
>-Matt
>  
>
I've updated the board to the latest BIOS revision and I'm still getting 
a Subsystem ID of 0. So updating the BIOS didn't help. As far as I know 
this is a retail board. It looks like it was manufactured sometime after 
June this year so it is possible it was a fairly early board.

Also is the patch update for the driver available now? I've looked 
around and didn't notice any changes to any code in CVS so if you have a 
patch I'd be glad to try it out. I'm running 1.0.9b of ALSA but I don't 
mind updating to the latest and greatest.


Michael



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
