From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Driver Programming
Date: Fri, 26 Nov 2004 09:47:20 +0100 (CET)
Message-ID: <XFMail.20041126094720.pochini@shiny.it>
References: <41A60B97.3010809@fetron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41A60B97.3010809@fetron.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: " (Klaus Fetscher)" <K.Fetscher@t-online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 25-Nov-2004 Klaus Fetscher wrote:

> I have read the documentation "Writing an Alsa Driver" but I am confused 
> about the meaning of PCM Streams and Substreams. What must I declare, 
> one PCM Stream with three Substreams or 3 PCM Streams ?

How does your chip work ?  If I inderstood you correcty, it has three
independent stereo outputs and two inputs.

snd_pcm_new(chip->card, "name", DEV_0, THREE_OUT, TWO_IN, &pcm);

If each substream can be either mono or stereo, in the
.open() callback you'll set

runtime->hw->channels_min = 1;
runtime->hw->channels_max = 2;


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
