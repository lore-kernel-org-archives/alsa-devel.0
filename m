From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Tue, 08 Apr 2003 21:30:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E933167.6010300@superbug.demon.co.uk>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <20030408164241.GA4253@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030408164241.GA4253@ulima.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gregoire Favre wrote:

>On Tue, Apr 08, 2003 at 05:50:48PM +0200, Takashi Iwai wrote:
>
>  
>
>>i'm afraid that it's not so easy as it sounds.  it strongly depends
>>on the hardware driver implementation...
>>
>>about AC3, 32bit spdif is likely irrelevant.  A52 (AC3) is usally
>>packed into normal 16bit frames.
>>
>>does the click happen even if you use alsa-tool's ac3dec?
>>    
>>
>
>Yes and no:
>
>./ac3dec -C /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3 don't
>produce any sound at all now... except ONE big click at the beginning,
>same with -P and
>./ac3dec -R /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3
>5.1 Mode 44.1 KHz 256 kbps Complete Main Audio Service
>Using PCM device 'iec958:AES0=0x0,AES1=0x82,AES2=0x0,AES3=0x2'
>
>Produces also the same big click and then plays quiete good (only 2.0 no
>dolby digital is sent to the receiver...).
>
>Thank you very much,
>
>	Gr?goire
>________________________________________________________________
>http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
>
>  
>
On my SB Live, with AC3 I use: -
PCM device "iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2"

On your example AES0=0x0, whereas I have AES0=0x6.
It is AES0 which sets the non-audio bits in the SPDIF.

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
