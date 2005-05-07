From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Sat, 07 May 2005 20:27:53 +0800
Message-ID: <427CB449.3000108@netvigator.com>
References: <424A5D7D.2070400@netvigator.com>	<Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>	<425E8CC5.3030601@netvigator.com>	<s5hy8bkchnd.wl@alsa2.suse.de>	<4264C3A5.50105@netvigator.com> <s5h64yjcdg7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64yjcdg7.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
> Raymond wrote:
> 
>>
>>1) Why samplerate is missing in soundfont_sample_info_t ?
>>
>>The samples in au30gm.arl have different samplerates.
> 
> 
> The sample rate is defined in soundfont_voice_info_t.
> 

The rate of some samples are 44100Hz but most of the samples are not 44100Hz

It seem that only layers of generators and samples are loaded from the 
soundfont file and none of the modulators are passed from the soundfont 
to the wavetable synth.








-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
