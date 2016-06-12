From: Joe Perches <joe@perches.com>
Subject: Re: [very-RFC 5/8] Add TSN machinery to drive the
 traffic from a shim over the network
Date: Sun, 12 Jun 2016 00:35:10 -0700
Message-ID: <1465716910.25087.88.camel__24267.2869157561$1465717398$gmane$org@perches.com>
References: <1465683741-20390-1-git-send-email-henrik@austad.us>
 <1465683741-20390-6-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1465683741-20390-6-git-send-email-henrik@austad.us>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: henrk@austad.us, linux-netdev@vger.kernel.org, alsa-devel@vger.kernel.org, Henrik Austad <haustad@cisco.com>, "David S. Miller" <davem@davemloft.net>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2016-06-12 at 00:22 +0200, Henrik Austad wrote:
> From: Henrik Austad <haustad@cisco.com>
> =

> In short summary:
> =

> * tsn_core.c is the main driver of tsn, all new links go through
> =A0 here and all data to/form the shims are handled here
> =A0 core also manages the shim-interface.
[]
> diff --git a/net/tsn/tsn_configfs.c b/net/tsn/tsn_configfs.c
[]
> +static inline struct tsn_link *to_tsn_link(struct config_item *item)
> +{
> +	/* this line causes checkpatch to WARN. making checkpatch happy,
> +	=A0* makes code messy..
> +	=A0*/
> +	return item ? container_of(to_config_group(item), struct tsn_link, grou=
p) : NULL;
> +}

How about

static inline struct tsn_link *to_tsn_link(struct config_item *item)
{
	if (!item)
		return NULL;
	return container_of(to_config_group(item), struct tsn_link, group);
}
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
