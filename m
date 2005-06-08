From: Igor Kovalenko <garrison@mail.ru>
Subject: Re: Re: [Openvortex-dev] Re: Re: [ALSA - driver	0001138]:
 errors when installing au8820 modules
Date: Wed, 08 Jun 2005 22:12:58 +0400
Message-ID: <42A7352A.2070502@mail.ru>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<200506071917.42953.alien999999999@users.sourceforge.net>	<42A5DB84.2030407@mail.ru>	<200506072002.49600.alien999999999@users.sourceforge.net>	<s5hacm1kv7f.wl@alsa2.suse.de> <42A6D936.8040101@netvigator.com> <s5h3brtkplx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3brtkplx.wl@alsa2.suse.de>
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
Cc: Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 08 Jun 2005 19:40:38 +0800,
> Raymond wrote:
> 
>>
>>typedef struct {
>>	unsigned int *this00;	/*CAsp4HwIO */
>>	long this04;		/* How many filters for each side (default = 10) */
>>	long this08;		/* inited to cero. Stereo flag? */
>>} eqhw_t;
>>
>>static void vortex_EqHw_SetLevels(vortex_t * vortex, u16 peaks[])
>>{
>>	eqhw_t *eqhw = &(vortex->eq.this04);
>>	int i;
>>
>>	/* set left peaks */
>>	for (i = 0; i < eqhw->this04; i++) {
>>		hwwrite(vortex->mmio, 0x2b024 + i * VORTEX_BAND_COEFF_SIZE, peaks[i]);
>>	}
>>
>>	hwwrite(vortex->mmio, 0x2b3cc, peaks[eqhw->this04]);
>>	hwwrite(vortex->mmio, 0x2b3d8, peaks[eqhw->this04 + 1]);
>>
>>	/* set right peaks */
>>	for (i = 0; i < eqhw->this04; i++) {
>>		hwwrite(vortex->mmio, 0x2b204 + i * VORTEX_BAND_COEFF_SIZE,
>>			peaks[i + (eqhw->this04 + 2)]);
>>	}
>>
>>	hwwrite(vortex->mmio, 0x2b3e4, peaks[2 + (eqhw->this04 * 2)]);
>>	hwwrite(vortex->mmio, 0x2b3f0, peaks[3 + (eqhw->this04 * 2)]);
>>}
>>
>>
>>	vortex_EqHw_SetLevels(vortex, (u16 *) eq_levels);
>>
>>
>>
>>
>>What is the reason to increase the size of the array eq_levels from 32 
>>to 64 ?  ( eqhw->this04 seem to be 10 )
> 
> 
> I guess he wants to keep the total array size just to be sure.
> But it seems not necessary.

Exactly for that purpose. I do not know if other (au8810 or au8830) use more
than au8820 in that array.

> (Oh, and the cast above is evil.  Let's remove it.)
> 
> Above all, any chance to rename the mysterious this* fields to more
> understandable ones?
> 
I believe original author can tell us more :) Actually that this04 seems to
be not needed at all (I preferred to keep all struct sizes the same in 64bit
to not bother with hardware formats etc.)

-- 
Kind regards,
Igor V. Kovalenko


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
