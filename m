From: Chris Horler <chris.horler@clara.co.uk>
Subject: Fwd: Audigy extin extout module parameters
Date: Sat, 21 Feb 2004 09:26:01 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402210926.01107.chris.horler@clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I took another look this morning and I'm now left thinking that for Audigy 
users these module parameters (extin, extout) make no difference.

static int __devinit _snd_emu10k1_audigy_init_efx(emu10k1_t *emu)

sets up controls, but I don't see it reading the values of extin or extout 
like the init for the emu10k1 does.

Is this because now most features at the Audigy driver level are inplace the 
driver init function could use a rewrite?

Thanks,

Chris


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
