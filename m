From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: Problems with RME Multiface on a Titanium	Powerbook
Date: Wed, 29 Dec 2004 14:01:04 +0000
Message-ID: <20041229140104.GA8354@palantir8>
References: <20982.1104290330@www53.gmx.net> <30018.1104291992@www28.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <30018.1104291992@www28.gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Try commenting out the "dbri" module in your /etc/X11/XF86Config-4.
I know it sounds strange, but DRM in the radeon driver locks all
pages in memory. That causes havoc with sound and anything real-time.

Also, do you get any output using snd-powermac?

Martin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
