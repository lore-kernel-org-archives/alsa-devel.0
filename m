From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: PCM format restrict dilema
Date: Wed, 17 Sep 2003 15:50:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6874C8.9090103@superbug.demon.co.uk>
References: <200309171422.h8HEMUVi016116@oud> <Pine.LNX.4.53.0309171615190.5983@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309171615190.5983@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 17 Sep 2003, Paul Davis wrote:
> 
> 
>>>So, the application does the following: -
>>>1) I want there to be 8 periods or less, with a minimum of 2.
>>>2) I want the buffer to be about 500ms long or less, with a minimum or 100ms
>>>3) I want the period size to have a min value of x, and a max value or y.
>>>4) Now calculate the actual sizes based on all the above information.
>>>(i.e. The buffer_size, and period_size values are not set until stage (4).
>>>At this point, alsa-lib would use the contrains above, and calculate the
>>>best values for buffer_size and period size based on the above, and also
>>>what the hardware can do.
>>>
>>>The reason I think it might help this way, is because period_size and
>>>buffer_size and number of periods are all closely linked, so we should
>>>not have to set them one at a time, but set them as a group.
>>
>>given that buffer_size = period_size * nperiods, why try to set the
>>buffer size at all? i've never set the buffer size in any ALSA app - i
>>always set nperiods first, then the period size.
> 
> 
> Good point. This algorithm sounds robust.

How would that algorithm handle the "dmix" case, when nperiods != integer?

> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
