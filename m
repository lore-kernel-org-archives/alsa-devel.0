From: Taupter <taupter@baydenet.com.br>
Subject: Re: Quick SBLive/AWE32 synth question
Date: Wed, 31 Jul 2002 05:46:13 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D47A3D5.4080305@baydenet.com.br>
References: <200207301624.02609.bownie@bownie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richard Bown wrote:
> Lazy question - without searching through bug database or getting latest ALSA CVS
> (0.9.0 beta12) is there any history or known bug when repeatedly playing the a note
> of the same pitch through the SBLive or AWE32 onboard synth?
> 
> Given 4 crotchets in a bar playing through the ALSA seq - routing to a soft
> synth (iiwusynth) or external MIDI device the notes sound correctly - routing
> through the onboard wavetable synth the first note sounds correctly but the
> following three (at the same pitch, remember) sound but have quaver-like durations.
> 
> Doesn't sound like an app problem as the interface is the same for any ALSA client
> so I'm wondering if anyone has seen this too before I start scouring?
> 
> B


I heard the same effect on a Soundblaster Live 5.1 loaded with the 
8mbgmsfx.sf2 bank and alsa-driver 0.9.0rc2. (MDK8.2 i586 kernel 
2.4.18-8.1mdk).


Taupter



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
