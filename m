From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: Re: hw_pointer error message triggered without need
Date: Wed, 22 Oct 2003 10:16:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F963CEF.30105@uni-oldenburg.de>
References: <3F9552BA.1020404@uni-oldenburg.de>	<s5hd6cqcyry.wl@alsa2.suse.de>	<Pine.LNX.4.53.0310211910520.1483@pnote.perex-int.cz> <s5h8ynecw5s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8ynecw5s.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>>well, it's not unnecessary but too strict.

Yes.

> the problem is that this check is too strict when only two periods are
> used.  since buffer_size/2 == period_size, if the update of hwptr is
> delayed even for one sample, it won't pass.

This is exactly what happens in my case.

>>Anyway, I think that we should leave the check as is for debugging
>>purposes (we should know that something is failing).
> 
> 
> sure, it's harmless message (as long as it comes from
> snd_pcm_update_hw_ptr()) but too annoying.  there are too many
> sloppy hardwares...

After printing the error message is printed, the function returns 
immediately. Can you confirm that this does not have negative side 
effects like dropped frames?

Besides, the error messages popping up in the console interfere visually 
with the text mode interface of the sound app that I use.

   Tobias




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
