From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Alsa-user] [PATCH] emu10k1 multichannel
	support
Date: Fri, 21 Jan 2005 16:41:48 -0500
Message-ID: <1106343708.3232.45.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <20050119195154.GR27550@samad.com.au>
	 <1106169110.3050.9.camel@krustophenia.net>
	 <20050119221903.GD14030@samad.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050119221903.GD14030@samad.com.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alexander Samad <alex@samad.com.au>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-01-20 at 09:19 +1100, Alexander Samad wrote:
> Hi
> 
> Sorry to bug you, but I used aplay -v on plughw0,3 and I saw that I
> have the 16 channels, I think the problem is I can't move it into
> digital output ????
> 
> 
> plus how do I set it to 96Khz not 48 ???
> 

Actually there is an experimental patch for 24 bit and 96/192 support on
this card.  It probably conflicts with my patch.

http://www.alsa-project.org/~james/alsa-driver/p16v/

I would like to hear whether this works for you.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
