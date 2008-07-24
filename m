From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
 let	me apply hardware parameters
Date: Wed, 23 Jul 2008 17:46:12 -0700
Message-ID: <4887D0D4.9070608@cox.net>
References: <3B6F5C9068D5864096EB291236C3386F02CE1664@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D90D4248C5
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 02:46:14 +0200 (CEST)
In-Reply-To: <3B6F5C9068D5864096EB291236C3386F02CE1664@xmb-sjc-21d.amer.cisco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mitul Sen (misen)" <misen@cisco.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mitul Sen (misen) wrote:
> Hi, 
> 
>> -----Original Message-----
>> From: stan [mailto:ghjeold_i_mwee@cox.net] 
>> Sent: Wednesday, July 23, 2008 11:26 AM
>> To: Mitul Sen (misen)
>> Cc: alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] Setting format to 
>> SND_PCM_FORMAT_MU_LAW does not let me apply hardware parameters
>>
>> Mitul Sen (misen) wrote:
>>> Hi,
>>>
>>> I have tried using gdb both from the command line as you 
>> suggested and 
>>> also from within eclipse. Even though I can step through 
>> the code and 
>>> break properly, I think there is some mismatch between the 
>> source code 
>>> and object code used by gdb. I say that because it sometimes steps 
>>> through code in a way that makes no sense. For example, I 
>> see that a 
>>> particular 'if' condition is satified and it goes into the 
>> 'if' clause 
>>> and then again goes into the 'else' clause that is not expected. Is 
>>> there any module that needs to be reloaded after building and 
>>> installing the shared library? I have done a clean make at 
>> all times, 
>>> checked timestamps, even rebooted the machine in case some driver 
>>> related data needs to be reloaded at startup but none of 
>> this has helped.

/sbin/ldconfig refreshes the links for libraries.

>> I suspect you are debugging optimized code.  The optimizer 
>> rearranges and deletes instructions.  Did you specify -O0 so 
>> that no optimization occurs?  The other gotcha in the 
>> alsa-lib code is that some of the functions are actually 
>> macros.  They cannot be stepped through.  When you hit them 
>> in the debugger it is disconcerting.
> 
> I did specify -O0 to disable optimizations. 
> 
That's weird.  Don't have an explanation except yours, 
that you aren't debugging the code you think you are.
