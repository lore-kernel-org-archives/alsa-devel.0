From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: why do elements disappear?
Date: Fri, 04 Mar 2005 10:15:52 +0100 (CET)
Message-ID: <XFMail.20050304101552.pochini@shiny.it>
References: <1109840265.2840.45.camel@tux.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1109840265.2840.45.camel@tux.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 03-Mar-2005 Ronald S. Bultje wrote:

>> If the app is programmed in a passive manner, it will receive the ADD
>> and REMOVE events when new controls are created/deleted.  Then the app
>> has to take the corresponding action.
>
> I'm probably hitting a wall here, because I cannot really find any
> sample code (google) or API docs (alsa website) on this. [...]

I'm working on the same stuff because echomixer ignores events
and it's not good. Some sample code is here:

cd alsa-tools-1.0.8/
grep -r poll_descriptors .


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
