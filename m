From: Raymond <rayau@netvigator.com>
Subject: Re: Volume per voices [Feature Request]
Date: Fri, 05 Aug 2005 18:23:20 +0800
Message-ID: <42F33E18.5030208@netvigator.com>
References: <s5hll3slj32.wl%tiwai@suse.de>	<Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>	<42E889DD.2070808@netvigator.com>	<Pine.LNX.4.61.0507281032400.8458@tm8103.perex-int.cz>	<42ECFE46.9070201@netvigator.com> <s5h7jf69fkp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jf69fkp.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Mon, 01 Aug 2005 00:37:26 +0800,
> Raymond wrote:
> 
>>Jaroslav Kysela wrote:
>>
>>>On Thu, 28 Jul 2005, Raymond wrote:
>>>
>>>
>>>
>>>>In theory, and sound cards with hardware mixing can support this kind of
>>>>volume control.
>>>>
>>>
>>>Nope. Please, define the controls at the driver initialization phase and 
>>>make them inactive when the stream is not open. See emu10k1 or trident 
>>>driver for hints. You must also map the voice volume with substream 
>>>number.
>>>
>>
>>Beside volume control, Is it feasible to bind other controls (e.g.
>>Interaural Time Difference, Interaural Level Difference and SAMPLE RATE 
>>CONVERTOR - Doppler Effect ) to the substream ?
> 
> 
> I think yes.  Whatever directly bound to a PCM substream should be
> handled as IFACE_PCM with a certain subdevice number.
> 
> 

It's OK for au88x0 to use a sample rate different from that of PCM 
stream play the PCM stream to produce a different pitch.

Does the alsa-lib really allow using a kcontrol to change the sample 
rate while playing the PCM to produce the Doppler Effect ?











-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
