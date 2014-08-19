From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [alsa-devel] [PATCH v4 0/2] mfd: arizona: add support for INn_MODE
 register control using platform data
Date: Tue, 19 Aug 2014 20:13:49 +0900
Message-ID: <20140819201349.18f4233f@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch series add support for INn_MODE register control using platform data.
Each input signal path can be configurated either as a Analogue or Digital using
the INn_MODE registers.

Changes for v4
- Update document content for more clarity

Changes for v3
- Change to use of_property_read_u32_array
- Fix a few typos
- Update commit message

Changes for v2
- Change to support
- Update commit message
- Update document content for more clarity

Inha Song (2):
  mfd: arizona: Add support for INn_Mode register control
  mfd: arizona: Update DT binding to support INn_MODE init_data

 Documentation/devicetree/bindings/mfd/arizona.txt | 7 +++++++
 drivers/mfd/arizona-core.c                        | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.0.0.390.gcb682f8
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
