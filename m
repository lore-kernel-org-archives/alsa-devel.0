From: Bob Ham <node@users.sourceforge.net>
Subject: guitar + sblive + ardour + ladspa effects
Date: 29 Jul 2002 21:08:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027973318.10978.62.camel@insanity>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>, Ardour Devel Mailing List <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all, 

This is what I want to do: guitar into the line input on the live drive,
that going into ardour, through a few ladspa effects, and out to the
speakers.  I can't seem to do this.  The only way I seem to be able to
get the input into ardour is to have it going through the speakers as
well so that both the input and the ladspa-processed output can be
heard.  I only want the ladspa-processed output.  Is this possible? 

I've had a search through the alsa-devel, alsa-user and ardour-devel
archives, as well as the alsa wiki and a google search.  I am yet to be
enlightened.  The SB-Live-mixer.txt is a probably a nice set of notes if
you're a driver writer, but I'm not. 

> name='Line LiveDrive Capture Volume',index=1
> name='Line LiveDrive Capture Volume',index=1
> 
> This control is used to attenuate samples from left and right I2S ADC
> inputs (on the LiveDrive). The result samples are forwarded to the ADC
> capture FIFO (thus to the standard capture PCM device).

What's the ADC capture FIFO?  What's the standard capture PCM device? 
What have these to do with recording from hw:0,0?  Why is it that ardour
only seems to be able to hear the line input when I put up the volume on
"Line LiveDrive" and not "Line LiveDrive Capture"?  What is the
"Capture" device sitting in alsamixer?  What difference does the little
red "Capture" make above the sliders in alsamixer? 

If it's not possible to this with only the sblive, I have the
motherboard's "soundcard" as well but how do I get jackd to deal with
more that one bit of hardware?  

I hope somebody can help as I'm utterly confused.

Bob

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
