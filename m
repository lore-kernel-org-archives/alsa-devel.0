From: Stephen Hassard <steve@hassard.net>
Subject: Envy24HT mixer restore problem with M-Audio Revolution 7.1 + Alsa
 1.0.4
Date: Mon, 12 Apr 2004 20:24:14 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407B5D5E.4020603@hassard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi there,

I've got an Envy24HT based M-Audio Revolution 7.1 and have a issue with 
Alsa 1.0.4.

When I set my 'DAC' and 'DAC1' channels to sane values (they correspond 
to L+R audio) and save my mixer settings via 'alsactl store', reboot and 
restore the settings via 'alsactl restore', my mixer settings appear to 
be normal in alsamixer, but I find that my left channel ('DAC') is 
mutted until I change the volume of 'DAC'. As soon as I touch the mixer 
for the 'DAC' channel, audio output is restored.

I didn't notice this a few revisions back, so I think a bug crept in 
recently ..

Thanks,
Steve


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
