From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: [Rosegarden-devel] Re: Sequencer port type flags
Date: Sat, 10 May 2003 19:15:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305101915.39513.plcl@telefonica.net>
References: <Pine.LNX.4.44.0305091237280.1237-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305091237280.1237-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, rosegarden-devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Friday 09 May 2003 12:43, Jaroslav Kysela wrote:
> SNDRV_SEQ_PORT_TYPE_SYNTH define is for clients which can do direct
> wavetable synthesis (used by modplayers etc.)

Emu chip based soundcards, as SoundBlaster AWE XX, are able to do wavetable 
synthesis. Aren't it? The ALSA emu driver for these cards does not set 
SNDRV_SEQ_PORT_TYPE_SYNTH flag. See emux_seq.c:55

OTOH, opl3 ALSA driver is for a family of FM synths that doesn't do wavetable 
synthesis. This driver *sets* SNDRV_SEQ_PORT_TYPE_SYNTH flag. See  
opl3_seq.c:204

This seems contradictory with your explanation. Could you clarify if i missed 
something or if those drivers are wrong and need to be updated ?

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
