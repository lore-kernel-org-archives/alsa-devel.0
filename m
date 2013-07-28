From: Kai Vehmanen <kvlists@nosignal.fi>
Subject: Re: [ecasound] Garbage at end of playback: ecasound or
 alsa broken?
Date: Sun, 28 Jul 2013 04:29:12 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1307280249470.2634@ecabase.localdomain>
References: <51EA4CDE.2010503@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id E9C1C26165C
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 19:37:32 +0200 (CEST)
In-Reply-To: <51EA4CDE.2010503@t-online.de>
Content-ID: <alpine.DEB.2.00.1307280410251.2634@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: alsa-devel@alsa-project.org, ecasound-list@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, 20 Jul 2013, Knut Petersen wrote:

> Summary: A very short period (about 45ms) garbage is played at the end of every playback.
[...]
> Setup soundcards and cabling, execute
> "ecasound -t 2 -f:16,2,44100 -a:1 -i testin.wav -o alsahw,0,0  -a:2 -i alsahw,0,0 -o testout.wav"

this usage triggers multitrack recording mode in ecasound (ecasound will 
try to align recording of testin.wav to playout of testout.wav), and the 
symptoms sound like an issue with this mechanism.

I couldn't reproduce this with my setup (ice1712), so could you retry the 
test with "-z:notintbuf"? If the problem still persists, can you send me 
(may be large, so please send offline) logs when run with "-dd"?
