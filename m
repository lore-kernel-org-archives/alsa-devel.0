From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: upmixing line in - emu10k1 sb live 5.1
Date: Sun, 13 Feb 2005 16:31:37 -0500
Message-ID: <1108330297.25912.11.camel@krustophenia.net>
References: <5edc2c9309dcc338399014c07df92a2d@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <5edc2c9309dcc338399014c07df92a2d@yahoo.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Thompson <dwhthompson@yahoo.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-02-13 at 15:07 +0000, David Thompson wrote:
> I am currently running VDR on my linux 2.6.8, SuSE 9.2 box running alsa 
> 1.0.6 and would like to upmix the 2 channel dvb audio to analogue 5.1 
> from my ttpci premium card that is fed into my soundblaster live 5.1 
> soundcard via the line in port using the emu10k1 driver.
> 
> Before I used a ttusb budget device with vdr xine and got used to the 
> 5.1 upmixed audio which xine upmixed!
> 
> Anyone know how to do this?  Have looked in vain thus far for a 
> solution ..  Do I need to write a audio filter for this - and if so can 
> anyone point me in the direction of a how to or sample file to do this?

It should just work.  If you set "Line In Volume" and "Line In Capture
Volume" to 100% then you should hear the line in on all the 5.1
channels.

Does it not work this way for you?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
