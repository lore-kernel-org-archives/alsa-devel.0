From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: Bug in emu10k1 multichannel support
Date: Fri, 11 Feb 2005 00:26:08 +0100
Message-ID: <420BED90.8090609@glocalnet.net>
References: <1106091073.24484.60.camel@krustophenia.net>	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>	 <41FE5838.4060907@glocalnet.net> <1108073865.11177.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108073865.11177.6.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2005-01-31 at 17:09 +0100, Mikael Magnusson wrote:
> 
>>Lee Revell wrote:
>>...
>>
>>>OK, I have posted the latest version:
>>>
>>>http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v007.patch
>>>
>>>All the known bugs I mentioned have been fixed.  I would like to test
>>>this version a while before signing off on it, then it should be ready
>>>to merge.  Since this patch touches almost every file in the driver, I
>>>can split it up and post it as a series of patches if necessary.
>>>
>>>The mixer controls for multichannel PCM have been fixed and moved to
>>>IFACE_PCM.  My solution was to use the same emu10k1_pcm_mixer_t
>>>structure internally as for regular PCM substreams, but only the "mono"
>>>component is exposed to userspace.
>>>
>>
>>...
>>
>>I'm having problems with emu10k1-multichannel-v008.patch. I have made a 
>>test program that demonstrates the bug. The program works alone, but the 
>>bug is triggered when I play a song in xmms, and at the same time run 
>>the test program.
>>
> 
> 
> Thanks, I have found and fixed the bug.
> 
> http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v009.patch
> 
> I believe the patch should now be mergeable.  All known bugs have been
> fixed, and since I announced it on LAU and LAD the patch has had fairly
> widespread testing.
> 
> I will break the patch up and post one patch per file in the next few
> days.
> 
> Lee
> 

I'm still having the same problem with emu10k1-multichannel-v009.patch 
and current CVS.

/Mikael Magnusson


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
