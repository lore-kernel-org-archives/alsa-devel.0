From: Lee Revell <rlrevell@joe-job.com>
Subject: RE: Sound with metal effect
Date: Sat, 02 Apr 2005 12:41:09 -0500
Message-ID: <1112463670.24446.11.camel@mindpipe>
References: <20050401151743.70754.qmail@web25110.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050401151743.70754.qmail@web25110.mail.ukl.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurielle LEA <lauriellelea@yahoo.fr>
Cc: mjander@users.sourceforge.net, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-04-01 at 17:17 +0200, Laurielle LEA wrote:
> In fact, in my read function, 
> 
> count = 320;
> rc = snd_pcm_readi(audio_hdl, (short*)ptr, count);
> I have to have rc = 320 but I receive just 160.
> 
> You tell me about other algorithms but I don't
> understand everything. Maybe I have to add other init
> hardware parameters ?
> 

Your read function takes the third argument in bytes.  But snd_pcm_readi
expects "count" to be in frames.  It looks like you have an 8 bit stereo
stream, or 2 bytes per frame.  So you did get 160 frames (320 bytes).
It looks like you need to set the device to 8 bit mono.

Please see alsa-lib/test/latency.c for an example of the correct usage.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
