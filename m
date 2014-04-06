From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH alsa-lib] pcm: rate: Don't return negative
 frame count on success in rewind
Date: Sun, 6 Apr 2014 10:46:49 +0800
Message-ID: <CAN8ccibLf=Gfv0R0Vj2wrZoL7AuUG0KEXkamU1NufJhs_qP8xA@mail.gmail.com>
References: <20140404182725.GQ24575@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140404182725.GQ24575@foghorn.codeweavers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Eikum <aeikum@codeweavers.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2014-04-05 2:27 GMT+08:00 Andrew Eikum <aeikum@codeweavers.com>:

> snd_pcm_rewind is documented to return <0 on failure and >=0 on
> success.
>


does all resampler  support rewind ?

why do rate plugin assume all hardware support rewind ?
