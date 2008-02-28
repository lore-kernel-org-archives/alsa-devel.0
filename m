From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Using ARRAY_SIZE macro when setting up ASoC audio
 map?
Date: Thu, 28 Feb 2008 09:15:39 +0200
Message-ID: <20080228091539.98a8a32a.jarkko.nikula@nokia.com>
References: <20080227134923.aa37870c.jarkko.nikula@nokia.com>
	<s5hy796s7d6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E3D9F1038D6
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 08:18:09 +0100 (CET)
In-Reply-To: <s5hy796s7d6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Feb 2008 17:15:49 +0100
"ext Takashi Iwai" <tiwai@suse.de> wrote:

> >  	/* Set up spitz specific audio path audio_map */
> > -	for (i = 0; audio_map[i][0] != NULL; i++) {
> > +	for (i = 0; i < ARRAY_SIZE(audio_map); i++) {
> 
> Does ARRAY_SIZE() work with two-dimensional arrays?  Just wondering...
> 
Yes it does when counting number of rows since sizeof(arr[0])
operator in ARRAY_SIZE returns a row size in bytes when used with
two-dimensional array.

-- 
Jarkko
