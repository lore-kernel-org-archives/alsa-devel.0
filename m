From: Ryan Pavlik <rpav@mephle.com>
Subject: Re: OSS emulation delays (?)
Date: Sat, 25 Oct 2003 15:04:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031025150404.04273ac4.rpav@mephle.com>
References: <20031023124542.0868bfd8.rpav@mephle.com>
	<3F992DF7.9090002@gmx.de>
	<s5hbrs6940t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrs6940t.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 24 Oct 2003 15:08:50 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 24 Oct 2003 14:49:43 +0100,
> Steffen Sauder wrote:
<snip>
> > I've had this problem with mplayer and oss emulation since alsa 0.9.3 i 
> > think (not quite sure). In older versions it
> > worked fine, but in newer versions and the current cvs it takes about a 
> > second for mplayer to skip anywhere. I didn't have this problem with any 
> > other app than mplayer though.
> 
> could you verify which version still worked fine?
> then we can spot out the affecting changes.

Well, the mplayer alsa driver has never worked.  IIRC, the xmms driver
works now after the update, whereas it didn't like the ice1712 card
before.  Must be some bridge code somewhere, I guess.

Anyhow, I believe it was at least a couple months between my last
updates, so I can't give an exact version, but I'll go try a few
releases soon and see if I can find a difference.

-- 
Ryan Pavlik <rpav@mephle.com>

"I was promised claws and an impossible biology!" - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
