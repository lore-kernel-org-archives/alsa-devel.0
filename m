From: Daniel Kasak <dkasak@nusconsulting.com.au>
Subject: Re: Oops when unloading modules
Date: Thu, 13 Apr 2006 08:36:01 +1000
Message-ID: <443D80D1.803@nusconsulting.com.au>
References: <4439E225.1070908@nusconsulting.com.au> <s5hirph918l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirph918l.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 10 Apr 2006 14:42:13 +1000,
> Daniel Kasak wrote:
>   
>> Hi all.
>>
>> I've been getting kernel oopses when unloading alsa modules, starting
>> from alsa-driver-1.0.10-rc3.
>>
>> I've tried a number of kernels, and the alsa-driver version has ranged
>> from 1.0.10-rc3 to 1.0.11-rc3 to 1.0.11-rc4 ( which is the one I'm
>> currently testing ).
>>
>> I was advised previously to test with a vanilla kernel, but
>> unfortunately I can't because I'm using a reiser4 root filesystem ...
>>     
>
> I've got a similar bug report but it happened only on mm tree.
> So, I suspected it's rather a problem in a different place from
> ALSA.
>   

You're right :)
I just booted a 2.6.16 kernel with a single patch - for reiser4, and I
can load and unload alsa modules to my heart's content!
Did you report the bug to the appropriate place for the mm tree? If not,
I will ...

-- 
Daniel Kasak
IT Developer
NUS Consulting Group
Level 5, 77 Pacific Highway
North Sydney, NSW, Australia 2060
T: (+61) 2 9922-7676 / F: (+61) 2 9922 7989
email: dkasak@nusconsulting.com.au
website: http://www.nusconsulting.com.au



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
