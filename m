From: Raymond <rayau@netvigator.com>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]: errors when
 installing au8820 modules
Date: Wed, 08 Jun 2005 19:40:38 +0800
Message-ID: <42A6D936.8040101@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<200506071917.42953.alien999999999@users.sourceforge.net>	<42A5DB84.2030407@mail.ru>	<200506072002.49600.alien999999999@users.sourceforge.net> <s5hacm1kv7f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacm1kv7f.wl@alsa2.suse.de>
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org


typedef struct {
	unsigned int *this00;	/*CAsp4HwIO */
	long this04;		/* How many filters for each side (default = 10) */
	long this08;		/* inited to cero. Stereo flag? */
} eqhw_t;

static void vortex_EqHw_SetLevels(vortex_t * vortex, u16 peaks[])
{
	eqhw_t *eqhw = &(vortex->eq.this04);
	int i;

	/* set left peaks */
	for (i = 0; i < eqhw->this04; i++) {
		hwwrite(vortex->mmio, 0x2b024 + i * VORTEX_BAND_COEFF_SIZE, peaks[i]);
	}

	hwwrite(vortex->mmio, 0x2b3cc, peaks[eqhw->this04]);
	hwwrite(vortex->mmio, 0x2b3d8, peaks[eqhw->this04 + 1]);

	/* set right peaks */
	for (i = 0; i < eqhw->this04; i++) {
		hwwrite(vortex->mmio, 0x2b204 + i * VORTEX_BAND_COEFF_SIZE,
			peaks[i + (eqhw->this04 + 2)]);
	}

	hwwrite(vortex->mmio, 0x2b3e4, peaks[2 + (eqhw->this04 * 2)]);
	hwwrite(vortex->mmio, 0x2b3f0, peaks[3 + (eqhw->this04 * 2)]);
}


	vortex_EqHw_SetLevels(vortex, (u16 *) eq_levels);




What is the reason to increase the size of the array eq_levels from 32 
to 64 ?  ( eqhw->this04 seem to be 10 )


Takashi Iwai wrote:

> 
> 
>>Index: alsa-kernel/pci/au88x0/au88x0_eqdata.c
>>===================================================================
>>RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_eqdata.c,v
>>retrieving revision 1.1
>>diff -u -r1.1 au88x0_eqdata.c
>>--- alsa-kernel/pci/au88x0/au88x0_eqdata.c	9 Mar 2004 11:52:13 -0000	1.1
>>+++ alsa-kernel/pci/au88x0/au88x0_eqdata.c	7 Jun 2005 17:56:37 -0000
>>@@ -104,7 +104,11 @@
>> };
>> 
>> /*_rodataba0:*/
>>-static long eq_levels[32] = {
>>+static u16 eq_levels[64] = {
>>+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>>+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>>+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>>+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>> 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>> 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
>> 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> 
> 
> You don't need to define values if the static array is initialize to
> zero.  In this case,
> 
> 	static u16 eq_levels[64];
> 
> would be better.
> 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
